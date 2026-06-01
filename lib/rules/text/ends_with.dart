import '../../x_validators.dart';

/// Validates that the trimmed input ends with [end].
class EndsWith extends TextXValidationRule {
  final String end;

  const EndsWith(this.end, [String? error]) : super(error);

  @override
  bool isValid(String input) => input.trim().endsWith(end);

  @override
  String toString() => 'validation.must_end_with';
}
