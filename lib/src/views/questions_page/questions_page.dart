import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/session_manager.dart';
import 'package:tembo_ui/app_state/source.dart';
import 'package:tembo_ui/source.dart';

final _pageStateNotifier = createModelStateNotifier<Question>();

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

class _QuestionsPageState extends TemboConsumerState<QuestionsPage> {
  @override
  Widget build(BuildContext context) => _QuestionsPageStateView(this);

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    ref.read(sessionManagerProvider.notifier).init(widget.ninNumber);
  }
}
