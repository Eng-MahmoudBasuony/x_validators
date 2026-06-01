import '../../x_validators.dart';

/// Validates that the input is an Egyptian mobile number (010/011/012/015 + 8 digits).
class IsEgyptianPhone extends TextXValidationRule {
  const IsEgyptianPhone([super.error]);

  @override
  bool isValid(String input) => isEgyptianNumber(input);
  @override
  String toString() => 'validation.is_egyptian_num';
}

/// Returns `true` if [str] is a valid Egyptian mobile number.
bool isEgyptianNumber(String str) {
  final phoneRegX = RegExp('^01[0125][0-9]{8}\$');

  return phoneRegX.hasMatch(str);
}
