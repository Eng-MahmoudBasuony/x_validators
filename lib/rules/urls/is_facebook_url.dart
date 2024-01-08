import '../../x_validators.dart';

class IsFacebookUrl extends TextXValidationRule {
  IsFacebookUrl([super.error]);

  @override
  bool isValid(String input) => isFacebookUrlValid(input);

  @override
  String toString() => 'not_valid_facebook_url';
}

bool isFacebookUrlValid(String url) {
  return RegExp(
    r'^((https?):\/\/)((www\.)?(facebook|fb)\.(com))\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  ).hasMatch(url);
}
