import '../../x_validators.dart';

/// Validates that the input is an IPv4 address (four dot-separated octets 0–255).
class IsIpAddress extends TextXValidationRule {
  const IsIpAddress([super.error]);

  @override
  bool isValid(String input) => isIpAddress(input);

  @override
  String get defaultMessage => 'validation.is_ip_address';
}

final _ipv4RegExp = RegExp(
  r'^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}'
  r'(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$',
);

/// Returns `true` if [input] is a string holding a strict dotted-quad IPv4
/// address — no leading zeros, signs or surrounding/embedded whitespace.
bool isIpAddress(Object? input) =>
    input is String && _ipv4RegExp.hasMatch(input);
