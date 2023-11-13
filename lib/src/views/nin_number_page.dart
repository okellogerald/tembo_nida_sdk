import 'package:tembo_nida_sdk/src/views/questions_page.dart';
import 'package:tembo_nida_sdk/tembo_nida_sdk.dart';
import 'package:tembo_ui/source.dart';

class NIDANumberPage extends StatefulWidget {
  const NIDANumberPage({super.key});

  static const name = "nida-number-page";

  @override
  State<NIDANumberPage> createState() => _NIDANumberPageState();
}

class _NIDANumberPageStateView extends StatelessWidget {
  final _NIDANumberPageState state;
  const _NIDANumberPageStateView(this.state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  void next() {
    rootNavigator.to(QuestionsPage.name, const QuestionsPage());
  }

  @override
  Widget build(BuildContext context) => _NIDANumberPageStateView(this);
}
