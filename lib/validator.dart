// Importing necessary libraries and dependencies
import 'package:x_validators/tr.dart';

import 'x_validators.dart';

// Defining a callback type for handling validation failures
typedef OnFailureCallBack = void Function(
  /// the text field content
  String? inputCallBack,

  /// the rules for this failed
  List<TextXValidationRule> rules,

  ///
  TextXValidationRule failedRule,
);

/// A function that builds and returns a `String Function(String value)`
/// which triggers the provided validation rules.
///
/// This function performs a validation loop for each rule in the provided list.
/// If a rule is of type `IsOptional`, the validation process marks the item as optional,
/// meaning that if the validation fails and the value is null, there will be no error.
/// However, if the validation fails and the value is not null, it returns the first failed error message.
String? Function(String?) xValidator(
  List<TextXValidationRule> rules, {
  OnFailureCallBack? onFailureCallBack,
}) {
  return (String? input) {
    // If the input is empty, return null (no error)
    if (input == null) return null;

    var isOptional = false; // Flag to track if the validation is optional

    /// Will contain the first failed rule message
    String? msg;

    for (final rule in rules) {
      /// If any rule is of type `IsOptional`,
      /// the validator loop will mark the validation process as optional,
      /// and it will not consider any failure from any rule.
      /// Otherwise, it works as usual and validates the next rule,
      /// returning only the first failure.
      if (rule is IsOptional) isOptional = true;

      /// Call the validate function and
      /// if it returns null, there will be no error;
      /// otherwise, it will return the failure message,
      /// which serves as the validation error for the entire process.
      msg = rule.isValid(input)
          ? null
          : (rule.error ?? XValidatorsLocalization.translate(rule));

      /// If the failure message `msg` has a value,
      /// it means some rule has failed.
      /// Return only the first failure,
      /// and there is no reason to continue validating the remaining rules.
      if (msg != null) {
        onFailureCallBack?.call(input, rules, rule);
        break;
      }
    }

    // If it's optional and the input is empty, return null (no error)
    if (isOptional && isEmpty(input)) return null;

    return msg;
  };
}
