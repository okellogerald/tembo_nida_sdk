import 'dart:convert';

class Question {
  final String inEnglish;
  final String inSwahili;
  final String code;

  const Question({
    required this.inEnglish,
    required this.inSwahili,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionEnglish': inEnglish,
      'questionSwahili': inSwahili,
      'questionCode': code,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      inEnglish: map['questionEnglish'] as String,
      inSwahili: map['questionSwahili'] as String,
      code: map['questionCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Question(inEnglish: $inEnglish, inSwahili: $inSwahili, code: $code)';

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;
  
    return 
      other.inEnglish == inEnglish &&
      other.inSwahili == inSwahili &&
      other.code == code;
  }

  @override
  int get hashCode => inEnglish.hashCode ^ inSwahili.hashCode ^ code.hashCode;
}
