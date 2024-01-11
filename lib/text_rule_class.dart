/// An abstract class representing a text validation rule.
abstract class TextXValidationRule {
  /// The error message to showcase validation failures.
  /// This message is used when the validation rule fails.
  const TextXValidationRule(this.error);

  /// Returns a boolean indicating whether the input is valid or not.
  /// Subclasses must implement this method to define the validation logic.
  bool isValid(String input);

  /// Passed through the constructor to provide a custom error message.
  /// If not provided, the rule may use a localized error message.
  final String? error;
}
