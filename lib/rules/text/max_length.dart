import '../../x_validators.dart';

/// checks if the input characters length is smaller than the max field
class MaxLength extends TextXValidationRule {
  final int max;

  const MaxLength(this.max, [String? error]) : super(error);

  @override
  bool isValid(String input) => input.trim().length <= max;
  @override
  String get defaultMessage => 'validation.max_length';
}
