import 'dart:convert';

class Profile {
  final String firstName;
  final String lastName;

  String get name {
    return "$firstName $lastName";
  }

  const Profile({
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Profile(firstName: $firstName, lastName: $lastName)';

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName && other.lastName == lastName;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}
