import 'package:tembo_nida_sdk/src/views/questions_page.dart';
import 'package:tembo_nida_sdk/tembo_nida_sdk.dart';
import 'package:tembo_ui/source.dart';

class NIDANumberPage extends TemboStatefulPage {
  const NIDANumberPage({super.key});

  @override
  String get name => "nida-number-page";

  @override
  State<NIDANumberPage> createState() => _NIDANumberPageState();
}

class _NIDANumberPageStateView extends StatelessWidget {
  final _NIDANumberPageState state;
  const _NIDANumberPageStateView(this.state);

  @override
  Widget build(BuildContext context) {
    return FocusWrapper(
      child: Scaffold(
        appBar: TemboAppBar(label: "NIDA Number(NIN)"),
        body: ListView(
          padding: kPagePadding,
          children: [
            TemboLabelledFormField(
              label: "NIN",
              controller: state.controller,
              formatters: [
                OnlyIntegerFormatter(),
              ],
            )
          ],
        ),
        bottomNavigationBar: TemboBottomButton(
          callback: state.next,
          text: context.l.next,
        ),
      ),
    );
  }
}

class _NIDANumberPageState extends State<NIDANumberPage> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  bool validate() {
    final text = controller.compactText;
    if (text?.length != 20) {
      showErrorSnackbar("message");
      return false;
    }

    return true;
  }

  void next() {
    final valid = validate();
    if (!valid) return;

    rootNavigator.to3(QuestionsPage(controller.compactText!));
  }

  @override
  Widget build(BuildContext context) => _NIDANumberPageStateView(this);
}
