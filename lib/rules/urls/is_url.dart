import '../../x_validators.dart';

class IsUrl extends TextXValidationRule {
  IsUrl([super.error]);

  @override
  bool isValid(String input) => isUrlValid(input);

  @override
  String toString() => 'not_valid_url';
}

bool isUrlValid(String url) {
  return RegExp(
    r'^((https?):\/\/)((www\.)?([a-zA-Z0-9!_$]+)\.([a-zA-Z]{2,5}))\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  ).hasMatch(url);
}
