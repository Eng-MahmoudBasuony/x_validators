import '../../x_validators.dart';

/// checks if input does not contain the provided value;

class NotContains extends TextXValidationRule {
  final String value;

  const NotContains(this.value, [String? error]) : super(error);

  @override
  bool isValid(String input) => !input.trim().contains(value);

  @override
  String get defaultMessage => 'validation.not_contains';
}
