import '../../x_validators.dart';

/// Validates that the input is an http or https URL.
class IsUrl extends TextXValidationRule {
  const IsUrl([super.error]);

  @override
  bool isValid(String input) => isUrlValid(input);

  @override
  String toString() => 'not_valid_url';
}

/// Returns `true` if [url] is a well-formed http or https URL.
bool isUrlValid(String url) {
  return RegExp(
    r'^((https?):\/\/)((www\.)?([a-zA-Z0-9!_$]+)\.([a-zA-Z]{2,5}))\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  ).hasMatch(url);
}
