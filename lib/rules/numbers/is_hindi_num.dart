import '../../x_validators.dart';

/// Validates a positive integer in Arabic-Indic digits, with no leading zero.
class IsHindiNum extends TextXValidationRule {
  const IsHindiNum([super.error]);

  @override
  bool isValid(String input) => isHindiNum(input);
  @override
  String toString() => 'validation.must_be_num';
}

/// Returns `true` if [input] is a positive integer in Arabic-Indic digits with no leading zero.
bool isHindiNum(String input) {
  //ToDo if it's starts with ٠ , i.e ٠٢٣٤٥٦٧ it's not a valid number
  return RegExp('^[\u0661-\u0669][\u0660-\u0669]*\$').hasMatch(input);
}
