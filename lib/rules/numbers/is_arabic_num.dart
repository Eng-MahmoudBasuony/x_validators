import '../../x_validators.dart';

/// Validates a positive integer in Latin digits, with no leading zero.
class IsArabicNum extends TextXValidationRule {
  const IsArabicNum([super.error]);

  @override
  bool isValid(String input) => isArabicNum(input);
  @override
  String get defaultMessage => 'validation.must_be_arabic_num';
}

final _arabicNumRegExp = RegExp(r'^[1-9][0-9]*$');

/// Returns `true` if [input] is a positive integer in Latin digits with no leading zero.
bool isArabicNum(String input) {
  //ToDo if it's starts with 0 , i.e 032158 it's not a valid number
  return _arabicNumRegExp.hasMatch(input);
}
