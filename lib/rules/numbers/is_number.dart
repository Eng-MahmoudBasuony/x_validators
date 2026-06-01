import '../../x_validators.dart';

/// checks if the input is a valid `integer`
class IsNumber extends TextXValidationRule {
  const IsNumber([super.error]);

  @override
  bool isValid(String input) => isNumber(input);

  @override
  String toString() => 'validation.must_be_int';
}

/// Returns `true` if [input] parses as a number via `num.tryParse`.
bool isNumber(String? input) => num.tryParse(input ?? '') != null;
