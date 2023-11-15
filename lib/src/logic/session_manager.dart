import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/api/repo.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';

import 'models/profile.dart';
import 'models/result.dart';

final sessionManagerProvider =
    StateNotifierProvider<SessionManager, List<Result>>((ref) {
  return SessionManager();
});

class SessionManager extends StateNotifier<List<Result>> {
  SessionManager() : super(const []);

  String? _nin;

  final _repo = IdentityRepository();

  String get nin => _nin!;

  void init(String nin) => _nin = nin;

  Future<Question> start() async {
    final qn = await _repo.startSession(nin);
    return qn;
  }

  Future<({Profile? profile, Question? newQn})> sendAnswer(
    Question qn,
    String answer,
  ) async {
    final result = await _repo.sendAnswer(qn, nin, answer);
    if (result.$2 != null) updateState(result.$2!.result);
    return (profile: result.$1, newQn: result.$2?.newQn);
  }

  void updateState(Result result) {
    final current = List<Result>.from(state);
    current.add(result);
    state = current;
    print(state);
  }
}
