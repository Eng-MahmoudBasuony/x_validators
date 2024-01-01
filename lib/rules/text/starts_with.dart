import '../../x_validators.dart';

class StartsWith extends TextXValidationRule {
  final Pattern pattern;

  StartsWith(this.pattern, [String? error]) : super(error);

  @override
  bool isValid(String input) => input.trim().startsWith(pattern);

  @override
  String toString() => 'validation.starts_with';
}
