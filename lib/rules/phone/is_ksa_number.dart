import '../../x_validators.dart';

class ISKsaPhone extends TextXValidationRule {
  ISKsaPhone([super.error]);

  @override
  bool isValid(String input) => isKsaPhone(input);
  @override
  String toString() => 'validation.is_ksa_num';
}

bool isKsaPhone(String input) {
  return RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
      .hasMatch(input);
}
