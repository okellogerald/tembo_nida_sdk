import 'package:flutter/material.dart';
import 'package:tembo_ui/components/source.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  static const name = "questions-view";

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
