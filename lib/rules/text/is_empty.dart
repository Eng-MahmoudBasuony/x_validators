import '../../x_validators.dart';

/// Validates that the input is empty or whitespace-only.
class IsEmpty extends TextXValidationRule {
  const IsEmpty([super.error]);

  @override
  bool isValid(String input) => isEmpty(input);
  @override
  String toString() => 'validation.is_empty';
}

/// `trim` the string then checks if `isEmpty`
/// if string is empty it will returns true
bool isEmpty(String? input) {
  return input?.trim().isEmpty ?? true;
}
