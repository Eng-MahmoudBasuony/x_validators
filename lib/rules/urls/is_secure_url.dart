import '../../x_validators.dart';

/// checks if the input is a secure `url`
class IsSecureUrl extends TextXValidationRule {
  const IsSecureUrl([super.error]);

  @override
  bool isValid(String input) => isSecureUrl(input);

  @override
  String get defaultMessage => 'validation.is_not_secure_url';
}

/// Returns `true` if [input] is a string starting with `https://` (case-insensitive).
bool isSecureUrl(Object? input) {
  String? url;
  if (input == null) {
    return false;
  } else if (input is String) {
    url = input.toLowerCase();
  }
  return url?.startsWith('https://') ?? false;
}
