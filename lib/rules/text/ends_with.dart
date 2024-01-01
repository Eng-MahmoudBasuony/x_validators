import '../../x_validators.dart';

class EndsWith extends TextXValidationRule {
  final String end;

  EndsWith(this.end, [String? error]) : super(error);

  @override
  bool isValid(String input) => input.trim().endsWith(end);

  @override
  String toString() => 'validation.must_end_with';
}
