import '../../x_validators.dart';

/// Validates that the input is a Facebook URL (facebook.com or fb.com).
class IsFacebookUrl extends TextXValidationRule {
  const IsFacebookUrl([super.error]);

  @override
  bool isValid(String input) => isFacebookUrlValid(input);

  @override
  String get defaultMessage => 'validation.is_not_facebook_url';
}

final _facebookUrlRegExp = RegExp(
  r'^https?:\/\/(www\.)?(facebook|fb)\.com(\/[-a-zA-Z0-9()@:%_+.~#?&/=]*)?$',
);

/// Returns `true` if [url] is an http or https Facebook URL.
bool isFacebookUrlValid(String url) => _facebookUrlRegExp.hasMatch(url);
