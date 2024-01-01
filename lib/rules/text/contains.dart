import '../../x_validators.dart';

/// checks if the input does contain the provided value;

class Contains extends TextXValidationRule {
  final String value;

  Contains(this.value, [String? error]) : super(error);

  @override
  bool isValid(String input) => input.trim().contains(value);
  @override
  String toString() => 'validation.is_it_contains';
}
