import '../../x_validators.dart';

/// Validates that the input is a YouTube URL (youtube.com).
class IsYoutubeUrl extends TextXValidationRule {
  const IsYoutubeUrl([super.error]);

  @override
  bool isValid(String input) => isYoutubeUrLValid(input);

  @override
  String toString() => 'not_valid_youtube_url';
}

/// Returns `true` if [url] is an http or https YouTube URL.
bool isYoutubeUrLValid(String url) => RegExp(
  r'^((https?):\/\/)((www\.)?(youtube)\.(com))\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
).hasMatch(url);
