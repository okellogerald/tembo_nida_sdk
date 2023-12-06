import 'dart:convert';

import 'package:intl/intl.dart';

enum UserGender {
  male,
  female,
  ;

  static UserGender fromJson(String json) {
    if (json.toLowerCase() == "male") return UserGender.male;
    if (json.toLowerCase() == "female") return UserGender.female;
    throw "unknown sex";
  }
}

class UserInfo {
  final String firstName;
  final String lastName;
  final DateTime dob;
  final UserGender gender;

  String get name {
    return "$firstName $lastName";
  }

  const UserInfo({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
  });

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    String? gender;
    try {
      gender = map["sex"] as String?;
    } catch (_) {}

    late DateTime date;
    try {
      date = DateFormat("yyyy-MM-dd").parse(map["dateOfBirth"]);
    } catch (_) {
      throw "Inavalid Date";
    }

    return UserInfo(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      dob: date,
      gender: UserGender.fromJson(gender ?? ""),
    );
  }

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(firstName: $firstName, lastName: $lastName, dob: $dob, gender: $gender)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.dob == dob &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        dob.hashCode ^
        gender.hashCode;
  }
}
