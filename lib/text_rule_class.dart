//  interface for the x validation rules
//   extend it and implement :
//   `isValid` to override the validation logic
//   `translatedError` return translated message from nations
//   `nationsKey` return key to use with nations
//

abstract class TextXValidationRule {
  ///  message to show case validations fails

  const TextXValidationRule(this.error);

  ///  return a bool Either valid or NOT
  bool isValid(String input);

  /// passed throw constructor to skip localized error
  final String? error;
}
