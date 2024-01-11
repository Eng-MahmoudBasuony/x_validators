import 'x_validators.dart';

/// A class responsible for localization of validation error messages.
abstract class XValidatorsLocalization {
  // A map to store functions that translate TextXValidationRule instances into strings.
  static final _map = <String, String Function(TextXValidationRule)>{};

  /// Translates a TextXValidationRule into a localized error message using the registered translation function.
  /// If no translation function is registered for a specific rule type, it falls back to the default toString() representation.
  static String translate(TextXValidationRule rule) =>
      _map[rule.runtimeType.toString()] == null
          ? rule.toString()
          : _map[rule.runtimeType.toString()]!(rule);

  /// Registers a translation function for a specific TextXValidationRule type.
  /// This allows customizing the error message for each validation rule type.
  static void on<T extends TextXValidationRule>(
    String Function(TextXValidationRule) func,
  ) =>
      _map[T.toString()] = func;
}
