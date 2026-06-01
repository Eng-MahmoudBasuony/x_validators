import '../../x_validators.dart';

/// Validates that the input is an Instagram URL (instagram.com).
class IsInstagramUrl extends TextXValidationRule {
  const IsInstagramUrl([super.error]);

  @override
  bool isValid(String input) => isInstagramUrlValid(input);

  @override
  String get defaultMessage => 'validation.is_not_instagram_url';
}

final _instagramUrlRegExp = RegExp(
  r'^https?:\/\/(www\.)?instagram\.com(\/[-a-zA-Z0-9()@:%_+.~#?&/=]*)?$',
);

/// Returns `true` if [url] is an http or https Instagram URL.
bool isInstagramUrlValid(String url) => _instagramUrlRegExp.hasMatch(url);

/// Deprecated misspelling of [isInstagramUrlValid]; kept so existing callers
/// keep compiling. Will be removed in a future major release.
@Deprecated('Renamed to isInstagramUrlValid')
bool isInstgramUrlValid(String url) => isInstagramUrlValid(url);
