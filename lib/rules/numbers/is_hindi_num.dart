import '../../x_validators.dart';

/// Validates a positive integer in Arabic-Indic digits, with no leading zero.
class IsHindiNum extends TextXValidationRule {
  const IsHindiNum([super.error]);

  @override
  bool isValid(String input) => isHindiNum(input);
  @override
  String get defaultMessage => 'validation.must_be_hindi_num';
}

final _hindiNumRegExp = RegExp('^[١-٩][٠-٩]*\$');

/// Returns `true` if [input] is a positive integer in Arabic-Indic digits with no leading zero.
bool isHindiNum(String input) {
  //ToDo if it's starts with ٠ , i.e ٠٢٣٤٥٦٧ it's not a valid number
  return _hindiNumRegExp.hasMatch(input);
}
