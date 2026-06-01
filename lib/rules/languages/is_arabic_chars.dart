import '../../x_validators.dart';

/// Validates that the input contains only Arabic letters, whitespace and
/// Arabic-Indic digits (٠-٩).
class IsArabicChars extends TextXValidationRule {
  const IsArabicChars([super.error]);

  @override
  bool isValid(String input) => isArabicChars(input);

  @override
  String get defaultMessage => 'validation.is_arabic_chars';
}

final _arabicCharsRegExp = RegExp(r'^[\u0621-\u064A\s\u0660-\u0669]+$');

/// Returns `true` if [input] consists of Arabic letters, whitespace and
/// Arabic-Indic digits (٠-٩).
bool isArabicChars(String input) => _arabicCharsRegExp.hasMatch(input);
