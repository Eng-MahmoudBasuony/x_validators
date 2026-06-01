import '../../x_validators.dart';

/// Validates that the input contains only Arabic letters and whitespace.
class IsArabicChars extends TextXValidationRule {
  const IsArabicChars([super.error]);

  @override
  bool isValid(String input) => isArabicChars(input);

  @override
  String toString() => 'validation.is_arabic_chars';
}

/// Returns `true` if [input] consists of Arabic letters and whitespace.
bool isArabicChars(String input) =>
    RegExp(r'^[\u0621-\u064A\s\p{N}]+$').hasMatch(input);
