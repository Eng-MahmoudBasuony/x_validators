import '../../x_validators.dart';

/// Validates that the input is an Instagram URL (instagram.com).
class IsInstagramUrl extends TextXValidationRule {
  const IsInstagramUrl([super.error]);

  @override
  bool isValid(String input) => isInstgramUrlValid(input);

  @override
  String toString() => 'not_valid_instagram_url';
}

/// Returns `true` if [url] is an http or https Instagram URL.
bool isInstgramUrlValid(String url) => RegExp(
  r'^((https?):\/\/)((www\.)?(instagram)\.(com))\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
).hasMatch(url);
