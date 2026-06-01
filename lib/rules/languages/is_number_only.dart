import '../../x_validators.dart';

/// Validates that the input contains at least one digit.
class IsNumbersOnly extends TextXValidationRule {
  const IsNumbersOnly([super.error]);

  @override
  bool isValid(String input) => isNumbersOnly(input);

  @override
  String toString() => 'validation.is_numbers_only';
}

/// Returns `true` if [input] contains at least one digit.
bool isNumbersOnly(String input) => RegExp('[0-9]').hasMatch(input);
