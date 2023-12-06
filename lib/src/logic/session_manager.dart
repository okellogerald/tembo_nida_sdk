import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/api/repo.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/models/result.dart';

final sessionManagerProvider = Provider((_) => SessionManager());

class SessionManager {
  String? _nin;

  final _repo = IdentityRepository();

  String get nin => _nin!;

  void init(String nin) => _nin = nin;

  Future<Question> start() async {
    return await _repo.startSession(nin);
  }

  Future<Result> sendAnswer(Question qn, String answer) async {
    return await _repo.sendAnswer(qn, nin, answer);
  }
}
