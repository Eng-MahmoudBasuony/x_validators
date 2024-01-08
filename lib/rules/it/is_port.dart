import '../../x_validators.dart';

/// checks if the input is a valid `port`
class IsPort extends TextXValidationRule {
  const IsPort([super.error]);

  @override
  bool isValid(String input) => isPort(input);

  @override
  String toString() => 'validation.is_not_port';
}

// returns true if the input is valid port number
bool isPort(Object? input) {
  num? _port;
  if (input is String) {
    _port = num.tryParse(input);
  } else if (input is num) {
    _port = input;
  }
  if (_port != null && _port.toInt() != _port) {
    return false;
  }

  return _port != null && 0 <= _port && _port <= 65535;
}
