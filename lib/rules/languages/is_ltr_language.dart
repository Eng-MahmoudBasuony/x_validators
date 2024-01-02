// Importing the main x_validators library
import '../../core/utils/language_utils.dart';
import '../../x_validators.dart';

// A validation rule to check if a language code is LTR (Left-to-Right)
class IsLtrLanguage extends TextXValidationRule {
  // Constructor to initialize the rule with an optional error message
  IsLtrLanguage([super.error]);

  // Override isValid method to implement the LTR language validation
  @override
  bool isValid(String input) => LanguageUtils.isLtrLanguage(input);

  // Override toString method to provide a description for the rule
  @override
  String toString() => 'validation.is_not_ltr_language_code';
}
