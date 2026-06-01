import '../../x_validators.dart';

/// Validates that the input is an IPv4 address (four dot-separated octets 0–255).
class IsIpAddress extends TextXValidationRule {
  const IsIpAddress([super.error]);

  @override
  bool isValid(String input) => isIpAddress(input);

  @override
  String toString() => 'validation.is_ip_address';
}

/// Returns `true` if [input] is a string holding a dotted-quad IPv4 address.
bool isIpAddress(Object? input) {
  if (input == null || input is! String) {
    return false;
  } else {
    final ipParts = input.split('.');
    if (ipParts.length != 4) {
      return false;
    }
    bool isValid = true;
    for (final part in ipParts) {
      try {
        final int value = int.parse(part);
        if (value < 0 || value > 255) {
          isValid = false;
          break;
        }
      } catch (e) {
        isValid = false;
        break;
      }
    }
    return isValid;
  }
}
