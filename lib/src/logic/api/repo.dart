import 'package:tembo_nida_sdk/src/logic/models/question.dart';

import '../models/profile.dart';
import '../models/result.dart';
import 'api.dart';

class IdentityRepository {
  final _api = IdentityVerificationAPI();

  Future<Question> startSession(String nin) async {
    final body = await _api.startSession(nin);
    return Question.fromMap(body["result"]);
  }

  Future<Result> sendAnswer(
    Question qn,
    String nin,
    String answer,
  ) async {
    final body = await _api.sendAnswer(nin, qn.code, answer);

    try {
      final q = Question.fromMap(body["result"]);
      return (profile: null, newQn: q);
    } catch (_) {}

    try {
      final p = Profile.fromMap(body["result"]);
      return (profile: p, newQn: null);
    } catch (_) {}

    if (body["result"] == null) {
      // could not provide KYC data because most qns were answered incorrectly
      return (profile: null, newQn: null);
    }

    throw "We could not process the result";
  }
}
