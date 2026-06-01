import '../../x_validators.dart';

/// Validates that the input is a YouTube URL (youtube.com).
class IsYoutubeUrl extends TextXValidationRule {
  const IsYoutubeUrl([super.error]);

  @override
  bool isValid(String input) => isYoutubeUrLValid(input);

  @override
  String get defaultMessage => 'validation.is_not_youtube_url';
}

final _youtubeUrlRegExp = RegExp(
  r'^https?:\/\/(www\.)?youtube\.com(\/[-a-zA-Z0-9()@:%_+.~#?&/=]*)?$',
);

/// Returns `true` if [url] is an http or https YouTube URL.
bool isYoutubeUrLValid(String url) => _youtubeUrlRegExp.hasMatch(url);
