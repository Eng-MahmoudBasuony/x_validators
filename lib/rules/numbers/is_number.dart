import '../../x_validators.dart';

/// checks if the input is a valid `integer`
class IsNumber extends TextXValidationRule {
  const IsNumber([super.error]);

  @override
  bool isValid(String input) => isNumber(input);

  @override
  String get defaultMessage => 'validation.must_be_int';
}

/// Returns `true` if [input] is a base-10 integer (surrounding whitespace is
/// trimmed first). Parsing is pinned to `radix: 10`, so the `0x` hex prefix,
/// scientific notation and decimals are all rejected — use [isDecimal] for
/// fractional values.
bool isNumber(String? input) =>
    int.tryParse(input?.trim() ?? '', radix: 10) != null;
