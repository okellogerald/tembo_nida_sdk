import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/session_manager.dart';
import 'package:tembo_nida_sdk/src/views/results_page.dart';
import 'package:tembo_nida_sdk/src/views/success_page.dart';
import 'package:tembo_ui/app_state/source.dart';
import 'package:tembo_ui/source.dart';

import '../logic/models/profile.dart';

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
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemboLoadingIndicator(),
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
    return FocusWrapper(
      child: Scaffold(
        appBar: TemboAppBar(label: "Answer Questions"),
        body: ListView(
          padding: kPagePadding,
          children: [
            const TemboFormLabel("Question (English)"),
            buildQn(qn.inEnglish),
            vSpace(),
            const TemboFormLabel("Question (Swahili)"),
            buildQn(qn.inSwahili),
            vSpace(),
            TemboLabelledFormField(
              label: "Answer",
              controller: state.answerController,
            ),
          ],
        ),
        bottomNavigationBar: TemboBottomButton(
          callback: state.sendAnswer,
          text: "Send Answer",
        ),
      ),
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

  void sendAnswer() {
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

        if(data.profile == null && data.newQn == null) {
          final results = ref.read(sessionManagerProvider);
          rootNavKey.push(ResultsPage(results));
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
