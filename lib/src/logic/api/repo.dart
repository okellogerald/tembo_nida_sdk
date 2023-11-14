import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/models/result.dart';

import '../models/profile.dart';
import 'api.dart';

class IdentityRepository {
  final _api = IdentityVerificationAPI();

  Future<Question> startSession(String nin) async {
    final body = await _api.startSession(nin);
    return Question.fromMap(body["result"]);
  }

  Future<(Profile? profile, ({Result result, Question newQn})?)> sendAnswer(
    Question qn,
    String nin,
    String answer,
  ) async {
    final body = await _api.sendAnswer(nin, qn.code, answer);

    bool? gotRight;
    Question? newQn;
    try {
      gotRight = body["prevCode"] == "123";
      newQn = Question.fromMap(body["result"]);
    } catch (_) {}

    if (gotRight != null && newQn != null) {
      return (
        null,
        (
          result: Result(question: qn, answer: answer, right: gotRight),
          newQn: newQn,
        )
      );
    }

    Profile? profile;

    try {
      profile = Profile.fromMap(body["result"]);
    } catch (_) {}

    if (profile != null) return (profile, null);

    throw "We could not process the result";
  }
}
