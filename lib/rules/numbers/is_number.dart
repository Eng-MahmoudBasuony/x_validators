import '../../x_validators.dart';

/// checks if the input is a valid `integer`
class IsNumber extends TextXValidationRule {
  IsNumber([super.error]);

  @override
  bool isValid(String input) => isNumber(input);

  @override
  String toString() => 'validation.must_be_int';
}

bool isNumber(String? input) => num.tryParse(input ?? '') != null;
