// Importing necessary libraries and dependencies
import 'x_validators.dart';

// Defining a callback type for handling validation failures
typedef OnFailureCallBack =
    void Function(
      /// the text field content
      String? inputCallBack,

      /// the rules for this failed
      List<TextXValidationRule> rules,

      ///
      TextXValidationRule failedRule,
    );

/// Builds a `String? Function(String?)` that runs [rules] in order against the
/// field value and returns the first failure message, or `null` when every rule
/// passes.
///
/// A `null` value is treated as empty (`''`), so required-style rules see and can
/// reject it. If an [IsOptional] rule is present anywhere in [rules] and the value
/// is empty, every rule is skipped and the field is considered valid.
String? Function(String?) xValidator(
  List<TextXValidationRule> rules, {
  OnFailureCallBack? onFailureCallBack,
}) {
  return (String? input) {
    // A null value is treated as empty so required-style rules can reject it,
    // rather than short-circuiting the whole validator to "valid".
    final value = input ?? '';

    /// Whether an `IsOptional` rule is present, scanned up-front so the result
    /// does not depend on where `IsOptional` sits in the list. An optional,
    /// empty field skips every other rule.
    final isOptional = rules.any((rule) => rule is IsOptional);
    if (isOptional && isEmpty(value)) return null;

    /// Will contain the first failed rule message
    String? msg;

    for (final rule in rules) {
      /// Call the validate function and
      /// if it returns null, there will be no error;
      /// otherwise, it will return the failure message,
      /// which serves as the validation error for the entire process.
      msg = rule.isValid(value)
          ? null
          : (rule.error ?? XValidatorsLocalization.translate(rule));

      /// If the failure message `msg` has a value,
      /// it means some rule has failed.
      /// Return only the first failure,
      /// and there is no reason to continue validating the remaining rules.
      if (msg != null) {
        onFailureCallBack?.call(value, rules, rule);
        break;
      }
    }

    return msg;
  };
}
