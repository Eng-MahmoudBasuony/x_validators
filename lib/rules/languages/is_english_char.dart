import '../../x_validators.dart';

/// Validates that the input contains only English (A–Z) letters.
class IsEnglishChars extends TextXValidationRule {
  const IsEnglishChars([super.error]);

  @override
  bool isValid(String input) => isEnglishChars(input);

  @override
  String toString() => 'validation.is_english_chars';
}

/// Returns `true` if [input] consists of English letters only.
bool isEnglishChars(String input) => RegExp(r'^[a-zA-Z]+$').hasMatch(input);
