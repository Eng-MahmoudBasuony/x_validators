// import 'package:queen_validators/queen_validators.dart';

// ignore: avoid_classes_with_only_static_members
import 'x_validators.dart';

// ignore: avoid_classes_with_only_static_members

abstract class XValidatorsLocalization {
  static final _map = <String, String Function(TextXValidationRule)>{};
  static String translate(
    TextXValidationRule rule,
  ) =>
      _map[rule.runtimeType.toString()] == null
          ? rule.toString()
          : _map[rule.runtimeType.toString()]!(rule);

  static void on<T extends TextXValidationRule>(
    String Function(TextXValidationRule) func,
  ) =>
      _map[T.toString()] = func;
}
