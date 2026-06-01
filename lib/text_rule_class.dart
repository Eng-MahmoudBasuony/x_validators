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

  /// The default message (or localization key) shown when the rule fails and
  /// no inline [error] or registered translator is provided.
  ///
  /// Built-in rules override this. The default delegates to [toString] so that
  /// custom rules which only override `toString()` keep working unchanged.
  String get defaultMessage => toString();
}
