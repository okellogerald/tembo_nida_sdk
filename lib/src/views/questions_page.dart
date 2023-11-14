import 'package:tembo_ui/source.dart';

class QuestionsPage extends TemboPage {
  const QuestionsPage({super.key});

  @override
  String get name => "questions-page";

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: "Answer Questions"),
      body: ListView(
        children: const [
          //
        ],
      ),
    );
  }
}
