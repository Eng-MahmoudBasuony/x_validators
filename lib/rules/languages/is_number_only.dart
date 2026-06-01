import '../../x_validators.dart';

/// Validates that the input is all digits (one or more, nothing else).
class IsNumbersOnly extends TextXValidationRule {
  const IsNumbersOnly([super.error]);

  @override
  bool isValid(String input) => isNumbersOnly(input);

  @override
  String get defaultMessage => 'validation.is_numbers_only';
}

final _numbersOnlyRegExp = RegExp(r'^[0-9]+$');

/// Returns `true` if [input] is one or more digits and nothing else.
bool isNumbersOnly(String input) => _numbersOnlyRegExp.hasMatch(input);
