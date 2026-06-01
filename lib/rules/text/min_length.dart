import '../../x_validators.dart';

/// checks if the input characters length is bigger than the min field

class MinLength extends TextXValidationRule {
  final int min;

  const MinLength(this.min, [String? error]) : super(error);

  @override
  bool isValid(String input) {
    return input.trim().length >= min;
  }

  @override
  String toString() => 'validation.min length is $min';
}

/// Returns `true` if [input], trimmed, is at least [min] characters long.
bool minLength(String? input, int min) {
  if (input == null) return false;
  return input.trim().length >= min;
}
