import '../../x_validators.dart';

/// Validates that the input is a Facebook URL (facebook.com or fb.com).
class IsFacebookUrl extends TextXValidationRule {
  const IsFacebookUrl([super.error]);

  @override
  bool isValid(String input) => isFacebookUrlValid(input);

  @override
  String toString() => 'not_valid_facebook_url';
}

/// Returns `true` if [url] is an http or https Facebook URL.
bool isFacebookUrlValid(String url) {
  return RegExp(
    r'^((https?):\/\/)((www\.)?(facebook|fb)\.(com))\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  ).hasMatch(url);
}
