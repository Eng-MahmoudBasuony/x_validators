import '../../x_validators.dart';

class IsEnglishChars extends TextXValidationRule {
  IsEnglishChars([String? error]) : super(error);

  @override
  bool isValid(String input) => isEnglishChars(input);

  @override
  String toString() => 'validation.is_english_chars';
}

bool isEnglishChars(String input) => RegExp(r'^[a-zA-Z]+$').hasMatch(input);
