import '../../x_validators.dart';

/// Validates that the input is a decimal number. Integers are accepted too,
/// since every integer is a valid `double`.
class IsDecimal extends TextXValidationRule {
  const IsDecimal([super.error]);

  @override
  bool isValid(String input) => isDecimal(input);

  @override
  String get defaultMessage => 'validation.must_be_double';
}

/// Returns `true` if [input] parses as a `double` via `double.tryParse`
/// (surrounding whitespace is trimmed first).
bool isDecimal(String? input) => double.tryParse(input?.trim() ?? '') != null;
