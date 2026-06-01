import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

/// A minimal custom rule used to verify the library is extensible.
class _StartsWithCapital extends TextXValidationRule {
  const _StartsWithCapital([super.error]);

  @override
  bool isValid(String input) =>
      input.isNotEmpty && input[0] == input[0].toUpperCase();

  @override
  String toString() => 'must start with a capital letter';
}

void main() {
  group('xValidator', () {
    test('returns null when every rule passes', () {
      final validate = xValidator([const IsRequired(), const MinLength(3)]);
      expect(validate('hello'), isNull);
    });

    test('an empty rule list always passes', () {
      final validate = xValidator([]);
      expect(validate('anything'), isNull);
      expect(validate(''), isNull);
    });

    test('returns the first failing rule message (order matters)', () {
      final validate = xValidator([const IsRequired(), const MinLength(5)]);
      expect(validate('abc'), 'validation.min length is 5');
    });

    test('keeps validating until the first failure', () {
      // First rule passes, second fails -> second message is returned.
      final validate = xValidator([const MinLength(2), const MaxLength(3)]);
      expect(validate('abcd'), 'validation.max length is 3');
    });

    test('a custom error message takes precedence over the default', () {
      final validate = xValidator([const IsRequired('Field is required')]);
      expect(validate(''), 'Field is required');
    });

    test('falls back to the rule toString() when no error is provided', () {
      final validate = xValidator([const MinLength(5)]);
      expect(validate('ab'), 'validation.min length is 5');
    });

    test('supports user-defined rules', () {
      final validate = xValidator([const _StartsWithCapital('Capitalize it')]);
      expect(validate('Hello'), isNull);
      expect(validate('hello'), 'Capitalize it');
    });

    group('IsOptional', () {
      test('skips validation when the input is empty', () {
        final validate = xValidator([const IsOptional(), const IsEmail()]);
        expect(validate(''), isNull);
      });

      test('skips validation when the input is whitespace-only', () {
        final validate = xValidator([const IsOptional(), const IsEmail()]);
        expect(validate('   '), isNull);
      });

      test('still validates when the input is non-empty', () {
        final validate = xValidator([const IsOptional(), const IsEmail()]);
        expect(validate('not-an-email'), isNotNull);
        expect(validate('user@example.com'), isNull);
      });
    });

    test(
      'onFailureCallBack reports the failing rule and the full rule list',
      () {
        String? captured;
        TextXValidationRule? failed;
        List<TextXValidationRule>? seenRules;
        final rules = [const IsRequired(), const MinLength(5)];
        final validate = xValidator(
          rules,
          onFailureCallBack: (input, allRules, failedRule) {
            captured = input;
            failed = failedRule;
            seenRules = allRules;
          },
        );

        validate('abc');
        expect(captured, 'abc');
        expect(failed, isA<MinLength>());
        expect(seenRules, same(rules));
      },
    );

    test('onFailureCallBack is not called when everything passes', () {
      var called = false;
      final validate = xValidator([
        const IsRequired(),
      ], onFailureCallBack: (_, _, _) => called = true);
      validate('ok');
      expect(called, isFalse);
    });

    // NOTE: a null input currently short-circuits to "valid", so IsRequired
    // does not catch null. TextFormField passes '' in practice. Treating null
    // as empty is planned as a breaking change (v2).
    test('null input is treated as valid today (known behavior)', () {
      final validate = xValidator([const IsRequired()]);
      expect(validate(null), isNull);
    });
  });

  // NOTE: localization registration mutates global state, so these tests run
  // last to avoid leaking a translator into the default-message tests above.
  group('XValidatorsLocalization', () {
    test('uses a registered translator for the rule type', () {
      XValidatorsLocalization.on<IsRequired>((rule) => 'هذا الحقل مطلوب');
      final validate = xValidator([const IsRequired()]);
      expect(validate(''), 'هذا الحقل مطلوب');
    });

    test('an inline error still beats a registered translator', () {
      XValidatorsLocalization.on<IsRequired>((rule) => 'translated');
      final validate = xValidator([const IsRequired('inline')]);
      expect(validate(''), 'inline');
    });
  });
}
