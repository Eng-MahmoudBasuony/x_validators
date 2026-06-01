import '../../x_validators.dart';

/// Validates that the input is a Saudi (KSA) mobile number.
class ISKsaPhone extends TextXValidationRule {
  const ISKsaPhone([super.error]);

  @override
  bool isValid(String input) => isKsaPhone(input);
  @override
  String get defaultMessage => 'validation.is_ksa_num';
}

final _ksaPhoneRegExp = RegExp(
  r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$',
);

/// Returns `true` if [input] is a valid Saudi mobile number in a supported format.
bool isKsaPhone(String input) => _ksaPhoneRegExp.hasMatch(input);

// https://gist.github.com/homaily/8672499
