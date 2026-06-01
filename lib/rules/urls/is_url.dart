import '../../x_validators.dart';

/// Validates that the input is an http or https URL.
class IsUrl extends TextXValidationRule {
  const IsUrl([super.error]);

  @override
  bool isValid(String input) => isUrlValid(input);

  @override
  String get defaultMessage => 'validation.is_not_url';
}

final _urlRegExp = RegExp(
  r'^https?:\/\/([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?([\/?#][-a-zA-Z0-9()@:%_+.~#?&/=]*)?$',
);

/// Returns `true` if [url] is a well-formed http or https URL.
bool isUrlValid(String url) => _urlRegExp.hasMatch(url);
