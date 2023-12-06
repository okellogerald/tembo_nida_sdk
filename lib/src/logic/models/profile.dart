import 'dart:convert';

import 'package:intl/intl.dart';

enum Sex {
  male,
  female,
  ;

  static Sex fromJson(String json) {
    if (json.toLowerCase() == "male") return Sex.male;
    if (json.toLowerCase() == "female") return Sex.female;
    throw "unknown sex";
  }
}

class Profile {
  final String firstName;
  final String lastName;
  final DateTime dob;
  final Sex gender;

  String get name {
    return "$firstName $lastName";
  }

  const Profile({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
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

    return Profile(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      dob: date,
      gender: Sex.fromJson(gender ?? ""),
    );
  }

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(firstName: $firstName, lastName: $lastName, dob: $dob, gender: $gender)';
  }

  @override
  bool operator ==(covariant Profile other) {
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
