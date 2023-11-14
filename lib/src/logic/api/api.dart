import 'dart:convert';

import 'base_http_api.dart';

class IdentityVerificationAPI extends BaseHTTPAPI {
  IdentityVerificationAPI() : super("nida");

  Future<Map<String, dynamic>> startSession(String nin) async {
    final data = {"nin": nin};
    final result = await post("rq-verify", body: jsonEncode(data));
    return result;
  }

  Future<Map<String, dynamic>> sendAnswer(
    String nin,
    String questionCode,
    String answer,
  ) async {
    final data = {
      "nin": nin,
      "questionCode": questionCode,
      "answer": "answer",
    };
    final result = await post("rq-verify", body: jsonEncode(data));
    return result;
  }
}
