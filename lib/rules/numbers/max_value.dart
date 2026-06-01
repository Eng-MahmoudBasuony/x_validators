import '../../x_validators.dart';

/// Validates that the parsed numeric input is less than or equal to [max].
class MaxValue extends TextXValidationRule {
  final num max;

  const MaxValue(this.max, [String? error]) : super(error);

  @override
  bool isValid(String input) => maxValue(input, max);
  @override
  String toString() => 'validation.must_be_max';
}

/// Returns `true` if [value] parses to a number less than or equal to [max].
bool maxValue(Object? value, num max) {
  num? val;
  if (value is String) {
    val = num.tryParse(value);
  } else if (value is num) {
    val = value;
  } else if (value is int) {
    val = value;
  } else if (value is double) {
    val = value;
  }
  return val != null && val <= max;
}
