import '../../x_validators.dart';

/// A validation rule that checks whether a language code is left-to-right (LTR).
class IsLtrLanguage extends TextXValidationRule {
  // Constructor to initialize the rule with an optional error message
  const IsLtrLanguage([super.error]);

  // Override isValid method to implement the LTR language validation
  @override
  bool isValid(String input) => LanguageUtils.isLtrLanguage(input);

  // Override toString method to provide a description for the rule
  @override
  String get defaultMessage => 'validation.is_not_ltr_language_code';
}
