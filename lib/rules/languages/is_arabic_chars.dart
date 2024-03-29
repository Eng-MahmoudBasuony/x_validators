import '../../x_validators.dart';

class IsArabicChars extends TextXValidationRule {
  IsArabicChars([super.error]);

  @override
  bool isValid(String input) => isArabicChars(input);

  @override
  String toString() => 'validation.is_arabic_chars';
}

bool isArabicChars(String input) =>
    RegExp(r'^[\u0621-\u064A\s\p{N}]+$').hasMatch(input);
