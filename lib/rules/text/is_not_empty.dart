import '../../x_validators.dart';

/// Validates that the input is not empty after trimming.
class IsRequired extends TextXValidationRule {
  const IsRequired([super.error]);

  @override
  bool isValid(String input) => isNotEmpty(input);
  @override
  String toString() => 'required';
}

/// `trim` the string then checks if `isNotEmpty`
bool isNotEmpty(String? string) {
  return string?.trim().isNotEmpty ?? false;
}
