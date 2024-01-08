import '../../x_validators.dart';

/// checks if the input is a valid `email` address
class IsEmail extends TextXValidationRule {
  const IsEmail([super.error]);

  @override
  bool isValid(String input) => isEmail(input);
  @override
  String toString() => 'validation.is_not_email_address';
}

/// checks if the value can be well formatted email address
bool isEmail(String? email) => EmailXValidator.validate(email ?? '');
