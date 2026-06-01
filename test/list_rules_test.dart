// `isIn` is also a matcher in package:test, so we hide it here to exercise the
// library's free function of the same name.
import 'package:test/test.dart' hide isIn;
import 'package:x_validators/x_validators.dart';

void main() {
  const allowed = ['white', 'black', 'gray'];

  group('IsIn / isIn', () {
    test('passes only when the value is in the list (case-sensitive)', () {
      expect(const IsIn(allowed).isValid('white'), isTrue);
      expect(const IsIn(allowed).isValid('black'), isTrue);
      expect(const IsIn(allowed).isValid('red'), isFalse);
      expect(const IsIn(allowed).isValid('White'), isFalse); // case matters
      expect(const IsIn(allowed).isValid(''), isFalse);
    });

    test('free function works with non-string objects too', () {
      expect(isIn('white', allowed), isTrue);
      expect(isIn(2, [1, 2, 3]), isTrue);
      expect(isIn(5, [1, 2, 3]), isFalse);
    });
  });

  group('IsNotIn / isNotIn', () {
    test('is the exact inverse of IsIn', () {
      expect(const IsNotIn(allowed).isValid('red'), isTrue);
      expect(const IsNotIn(allowed).isValid('white'), isFalse);
      expect(isNotIn('red', allowed), isTrue);
      expect(isNotIn('white', allowed), isFalse);
    });
  });

  group('ContainsAny / containsAny', () {
    test(
      'passes when any keyword is present (case-insensitive by default)',
      () {
        expect(ContainsAny(['world']).isValid('Hello World'), isTrue);
        expect(ContainsAny(['WORLD']).isValid('hello world'), isTrue);
        expect(ContainsAny(['foo', 'bar']).isValid('hello'), isFalse);
      },
    );

    test('an empty needle is always contained (edge case)', () {
      expect(ContainsAny(['']).isValid('hello'), isTrue);
    });

    test('free function honors the caseSensitive flag', () {
      expect(containsAny('Hello', ['LO'], caseSensitive: true), isFalse);
      expect(containsAny('Hello', ['LO']), isTrue); // default insensitive
    });

    test('free function honors the trim flag', () {
      // With trim off, the raw string is matched (still case-insensitive).
      expect(containsAny(' Foo ', ['foo'], trim: false), isTrue);
      expect(containsAny('xFoox', ['foo'], trim: false), isTrue);
      // trim off + case-sensitive: exact substring required.
      expect(
        containsAny('Foo', ['foo'], caseSensitive: true, trim: false),
        isFalse,
      );
      expect(
        containsAny('Foo', ['Foo'], caseSensitive: true, trim: false),
        isTrue,
      );
    });

    // NOTE: the `caseSensitive` FIELD on ContainsAny is dead — isValid never
    // forwards it, so the rule is always case-insensitive. Wiring it up is
    // planned as a breaking change (v2).
    test('the caseSensitive field has no effect (known dead field)', () {
      final rule = ContainsAny(['WORLD'])..caseSensitive = true;
      expect(rule.isValid('hello world'), isTrue);
    });
  });

  group('NotContainsAny / notContainsAny', () {
    test('is the inverse of ContainsAny', () {
      expect(const NotContainsAny(['foo', 'bar']).isValid('hello'), isTrue);
      expect(const NotContainsAny(['world']).isValid('Hello World'), isFalse);
      expect(notContainsAny('hello', ['foo']), isTrue);
      expect(notContainsAny('Hello World', ['world']), isFalse);
    });
  });
}
