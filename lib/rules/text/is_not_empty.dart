import '../../x_validators.dart';

class IsRequired extends TextXValidationRule {
  IsRequired([super.error]);

  @override
  bool isValid(String input) => isNotEmpty(input);
  @override
  String toString() => 'required';
}

/// `trim` the string then checks if `isNotEmpty`
bool isNotEmpty(String? string) {
  return string?.trim().isNotEmpty ?? false;
}
