import '../../x_validators.dart';

/// Validates that the trimmed input starts with [pattern].
class StartsWith extends TextXValidationRule {
  final Pattern pattern;

  const StartsWith(this.pattern, [String? error]) : super(error);

  @override
  bool isValid(String input) => input.trim().startsWith(pattern);

  @override
  String toString() => 'validation.starts_with';
}
