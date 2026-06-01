import '../../x_validators.dart';

/// checks if the input is a valid `port`
class IsPort extends TextXValidationRule {
  const IsPort([super.error]);

  @override
  bool isValid(String input) => isPort(input);

  @override
  String get defaultMessage => 'validation.is_not_port';
}

/// Returns `true` if [input] is an integer port in the range 0–65535.
bool isPort(Object? input) {
  num? port;
  if (input is String) {
    port = num.tryParse(input);
  } else if (input is num) {
    port = input;
  }
  if (port != null && port.toInt() != port) {
    return false;
  }

  return port != null && 0 <= port && port <= 65535;
}
