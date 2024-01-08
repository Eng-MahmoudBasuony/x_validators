abstract class TextXValidationRule {
  ///  message to show case validations fails

  const TextXValidationRule(this.error);

  ///  return a bool Either valid or NOT
  bool isValid(String input);

  /// passed throw constructor to skip localized error
  final String? error;
}
