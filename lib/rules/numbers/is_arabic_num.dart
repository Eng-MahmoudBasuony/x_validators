import '../../x_validators.dart';

/// Validates a positive integer in Latin digits, with no leading zero.
class IsArabicNum extends TextXValidationRule {
  const IsArabicNum([super.error]);

  @override
  bool isValid(String input) => isArabicNum(input);
  @override
  String toString() => 'validation.must_be_num';
}

/// Returns `true` if [input] is a positive integer in Latin digits with no leading zero.
bool isArabicNum(String input) {
  //ToDo if it's starts with 0 , i.e 032158 it's not a valid number
  return RegExp('^[1-9][0-9]*\$').hasMatch(input);
}
