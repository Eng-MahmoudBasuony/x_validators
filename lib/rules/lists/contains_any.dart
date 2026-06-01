import '../../x_validators.dart';

/// check if the value contain at lest one of String form the provided list

class ContainsAny extends TextXValidationRule {
  final List<String> value;

  /// When `true`, matching is case-sensitive. Defaults to `false`.
  final bool caseSensitive;

  const ContainsAny(this.value, {this.caseSensitive = false, String? error})
    : super(error);

  @override
  bool isValid(String input) =>
      containsAny(input, value, caseSensitive: caseSensitive);
  @override
  String get defaultMessage => 'validation.must_contains_any';
}

/// Returns `true` if [v] contains any entry from [list] (case-insensitive by default).
bool containsAny(
  String v,
  List<String> list, {
  bool caseSensitive = false,
  bool trim = true,
}) {
  if (trim) {
    return list.any(
      (e) => caseSensitive
          ? v.trim().contains(e.trim())
          : v.trim().toLowerCase().contains(e.trim().toLowerCase()),
    );
  }
  return list.any(
    (e) => caseSensitive
        ? v.contains(e.trim())
        : v.toLowerCase().contains(e.toLowerCase()),
  );
}
