import '../../x_validators.dart';

/// Validates that the parsed numeric input is greater than or equal to [min].
class MinValue extends TextXValidationRule {
  final num min;

  const MinValue(this.min, [String? error]) : super(error);

  @override
  bool isValid(String input) => minValue(input, min);
  @override
  String get defaultMessage => 'validation.must_be_min';
}

/// Returns `true` if [value] parses to a number greater than or equal to [min].
bool minValue(Object? value, num min) {
  num? val;
  if (value is String) {
    val = num.tryParse(value);
  } else if (value is num) {
    val = value;
  }
  return val != null && val >= min;
}
