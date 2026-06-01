import '../../x_validators.dart';

/// Validates that the input is a boolean literal — `true` or `false`.
class IsBool extends TextXValidationRule {
  const IsBool([super.error]);

  @override
  bool isValid(String input) => isBool(input);
  @override
  String get defaultMessage => 'validation.is_not_bool';
}

/// Returns `true` if [input] is a bool, or the trimmed, case-insensitive
/// string `'true'` or `'false'`.
bool isBool(Object? input) {
  return ['true', 'false', true, false].any((e) {
    if (e is String && input is String) {
      return e.compareTo(input.trim().toLowerCase()) == 0;
    } else {
      return e == input;
    }
  });
}
