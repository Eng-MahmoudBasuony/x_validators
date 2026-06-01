import '../../x_validators.dart';

/// A validation rule that checks whether a language code is right-to-left (RTL).
class IsRTLLanguage extends TextXValidationRule {
  // Constructor to initialize the rule with an optional error message
  const IsRTLLanguage([super.error]);

  // Override isValid method to implement the RTL language validation
  @override
  bool isValid(String input) => LanguageUtils.isRtlLanguage(input);

  // Override toString method to provide a description for the rule
  @override
  String get defaultMessage => 'validation.is_not_rtl_language_code';
}
