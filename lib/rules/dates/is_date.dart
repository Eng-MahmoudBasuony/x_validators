import '../../x_validators.dart';

class IsDate extends TextXValidationRule {
  const IsDate([String? error]) : super(error);

  @override
  bool isValid(String input) => isDate(input);

  @override
  String toString() => 'validation.is_not_date_format';
}

/// checks if the input is a valid `date` to parse by Dart `DateTime` class
bool isDate(String? v) => DateTime.tryParse(v ?? '') != null;
