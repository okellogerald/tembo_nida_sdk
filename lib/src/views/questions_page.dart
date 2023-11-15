import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/session_manager.dart';
import 'package:tembo_nida_sdk/src/views/success_page.dart';
import 'package:tembo_ui/app_state/source.dart';
import 'package:tembo_ui/source.dart';

import '../logic/models/profile.dart';
import 'failure_page.dart';

typedef _State = ({Profile? profile, Question? newQn});

final _pageStateNotifier = createModelStateNotifier<_State>();

final class QuestionsPage extends TemboConsumerPage {
  final String ninNumber;
  const QuestionsPage(this.ninNumber, {super.key});

  @override
  String get name => "questions-page";

  @override
  ConsumerState<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageStateView extends ConsumerWidget {
  final _QuestionsPageState state;
  const _QuestionsPageStateView(this.state);

  @override
  Widget build(BuildContext context, ref) {
    final pageState = ref.watch(_pageStateNotifier);
    return pageState.when(
      initial: buildLoading,
      loading: buildLoading,
      success: buildSuccess,
      // success: (_) => buildLoading(),
      error: (_) => buildError(),
    );
  }

  Widget buildError() {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: TemboAppBar(),
        body: TemboContainer(
          constraints: kMaxConstraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TemboText("An error happened"),
              vSpace(),
              TemboTextButton(
                onPressed: state.retry,
                child: TemboText(context.l.tryAgain),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildLoading() {
    return Scaffold(
      appBar: TemboAppBar(),
      body: TemboContainer(
        constraints: kMaxConstraints,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TemboLoadingIndicator(),
            Image.asset("packages/tembo_nida_sdk/assets/laoding.gif")
          ],
        ),
      ),
    );
  }

  Widget buildSuccess(_State data) {
    if (data.newQn != null) return buildQuestion(data.newQn!);

    return buildLoading();
  }

  Widget buildQuestion(Question qn) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: TemboAppBar(label: "Jibu Maswali"),
          body: FocusWrapper(
            child: ListView(
              padding: kPagePadding,
              children: [
                // const TemboFormLabel("Question (English)"),
                // buildQn(qn.inEnglish),
                // vSpace(),
                 TemboFormLabel(
                  "Swali: ",
                  style:  context.textTheme.bodyLarge.bold.withPrimaryColor,
                ),
                buildQn(qn.inSwahili),
                vSpace(),
              TemboLabelledFormField(
                    label: "Jibu:",
                    labelStyle: context.textTheme.bodyLarge.bold.withPrimaryColor,
                    controller: state.answerController,
                    textCapitalization: TextCapitalization.words,
                  )
              ],
            ),
          ),
          bottomNavigationBar: TemboBottomButton(
            callback: state.sendAnswer,
            text: "Send Answer",
          ),
        );
      }
    );
  }

  Widget buildQn(String data) {
    return Builder(builder: (context) {
      return TemboText(
        data,
        style: context.textTheme.bodyMedium.withFW600.withColor(
          context.colorScheme.onSurface,
        ),
      );
    });
  }
}

class _QuestionsPageState extends TemboConsumerState<QuestionsPage> {
  final answerController = TextEditingController();

  VoidCallback? callback;

  @override
  Widget build(BuildContext context) => _QuestionsPageStateView(this);

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    ref.read(sessionManagerProvider.notifier).init(widget.ninNumber);
    loadFirstQuestion();
  }

  void retry() {
    if (callback == null) return;

    callback!();
  }

  void loadFirstQuestion() {
    callback = loadFirstQuestion;
    final futureTracker = ref.read(futureTrackerProvider);

    Future<_State> future() async {
      final result = await ref.read(sessionManagerProvider.notifier).start();
      return (profile: null, newQn: result);
    }

    futureTracker.trackWithNotifier(
      notifier: ref.read(_pageStateNotifier.notifier),
      future: future(),
      onSuccess: (p0) => answerController.clear(),
    );
  }

  bool validate() {
    if (answerController.compactText == null) {
      showErrorSnackbar("Tafadhari andika jibu sahihi");
      return false;
    }

    return true;
  }

  void sendAnswer() {
    final valid = validate();
    if (!valid) return;

    callback = sendAnswer;
    final futureTracker = ref.read(futureTrackerProvider);

    futureTracker.trackWithNotifier(
      notifier: ref.read(_pageStateNotifier.notifier),
      future: ref.read(sessionManagerProvider.notifier).sendAnswer(
            ref.read(_pageStateNotifier).data!.newQn!,
            answerController.compactText!,
          ),
      onSuccess: (data) {
        answerController.clear();

        if (data.profile == null && data.newQn == null) {
          rootNavKey.push(const FailurePage());
          return;
        }

        if (data.profile != null) {
          rootNavKey.pop();
          rootNavKey.push(const SuccessPage());
        }
      },
    );
  }
}
