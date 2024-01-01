import '../../x_validators.dart';

class IsEgyptianPhone extends TextXValidationRule {
  IsEgyptianPhone([String? error]) : super(error);

  @override
  bool isValid(String input) => isEgyptianNumber(input);
  @override
  String toString() => 'validation.is_egyptian_num';
}

bool isEgyptianNumber(String str) {
  final phoneRegX = RegExp('^01[0125][0-9]{8}\$');

  return phoneRegX.hasMatch(str);
}
