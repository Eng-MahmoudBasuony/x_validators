import '../../x_validators.dart';

/// Validates that the input parses to a date strictly after [date].
class IsDateAfter extends TextXValidationRule {
  final DateTime date;

  const IsDateAfter(this.date, [String? error]) : super(error);

  @override
  bool isValid(String input) => isDateAfter(input, date);

  @override
  String get defaultMessage => 'validation.is_not_date_after';
}

/// Returns `true` if [input] (a `String` or `DateTime`) is strictly after [date].
bool isDateAfter(Object? input, DateTime date) {
  DateTime? parsed;
  if (input is String) {
    parsed = DateTime.tryParse(input);
  } else if (input is DateTime) {
    parsed = input;
  }
  return parsed != null && parsed.isAfter(date);
}
