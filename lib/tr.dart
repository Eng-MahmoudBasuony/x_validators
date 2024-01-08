
import 'x_validators.dart';

abstract class XValidatorsLocalization {
  static final _map = <String, String Function(TextXValidationRule)>{};

  static String translate( TextXValidationRule rule) => _map[rule.runtimeType.toString()] == null
      ? rule.toString()
      : _map[rule.runtimeType.toString()]!(rule);




  static void on<T extends TextXValidationRule>(
    String Function(TextXValidationRule) func,
  ) =>
      _map[T.toString()] = func;
}
