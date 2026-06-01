// `isEmpty` / `isNotEmpty` are also matchers in package:test, so we hide them
// here to test the library's free functions of the same name.
import 'package:test/test.dart' hide isEmpty, isNotEmpty;
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsRequired / isNotEmpty', () {
    test('non-empty text is valid', () {
      expect(const IsRequired().isValid('hello'), isTrue);
      expect(const IsRequired().isValid('  a  '), isTrue);
      expect(isNotEmpty('hello'), isTrue);
    });

    test('empty or whitespace-only text is invalid', () {
      expect(const IsRequired().isValid(''), isFalse);
      expect(const IsRequired().isValid('   '), isFalse);
      expect(const IsRequired().isValid('\t\n'), isFalse);
      expect(isNotEmpty('   '), isFalse);
      expect(isNotEmpty(null), isFalse);
    });
  });

  group('IsEmpty / isEmpty', () {
    test('empty or whitespace-only text is valid', () {
      expect(const IsEmpty().isValid(''), isTrue);
      expect(const IsEmpty().isValid('   '), isTrue);
      expect(const IsEmpty().isValid('\t'), isTrue);
      expect(isEmpty(null), isTrue);
    });

    test('non-empty text is invalid', () {
      expect(const IsEmpty().isValid('x'), isFalse);
      expect(const IsEmpty().isValid('  x  '), isFalse);
    });
  });

  group('Contains', () {
    test('detects a substring after trimming the input', () {
      expect(const Contains('lo').isValid('hello'), isTrue);
      expect(const Contains('hello').isValid('  hello  '), isTrue);
      expect(const Contains('zz').isValid('hello'), isFalse);
    });

    test('is case-sensitive', () {
      expect(const Contains('LO').isValid('hello'), isFalse);
    });

    test('an empty needle always matches (edge case)', () {
      expect(const Contains('').isValid('hello'), isTrue);
    });
  });

  group('NotContains', () {
    test('is the inverse of Contains', () {
      expect(const NotContains('zz').isValid('hello'), isTrue);
      expect(const NotContains('lo').isValid('hello'), isFalse);
    });

    test('an empty needle never passes (edge case)', () {
      expect(const NotContains('').isValid('hello'), isFalse);
    });
  });

  group('StartsWith', () {
    test('matches a string prefix after trimming', () {
      expect(const StartsWith('he').isValid('hello'), isTrue);
      expect(const StartsWith('he').isValid('   hello'), isTrue);
      expect(const StartsWith('lo').isValid('hello'), isFalse);
    });

    test('is case-sensitive', () {
      expect(const StartsWith('HE').isValid('hello'), isFalse);
    });

    test('accepts a RegExp pattern (Pattern type)', () {
      expect(StartsWith(RegExp(r'\d+')).isValid('123abc'), isTrue);
      expect(StartsWith(RegExp(r'\d+')).isValid('abc123'), isFalse);
    });

    test('an empty prefix always matches (edge case)', () {
      expect(const StartsWith('').isValid('hello'), isTrue);
    });
  });

  group('EndsWith', () {
    test('matches a suffix after trimming', () {
      expect(const EndsWith('lo').isValid('hello'), isTrue);
      expect(const EndsWith('lo').isValid('hello   '), isTrue);
      expect(const EndsWith('he').isValid('hello'), isFalse);
    });

    test('an empty suffix always matches (edge case)', () {
      expect(const EndsWith('').isValid('hello'), isTrue);
    });
  });

  group('Match', () {
    test('case-sensitive by default', () {
      expect(const Match('abc').isValid('abc'), isTrue);
      expect(const Match('abc').isValid('ABC'), isFalse);
    });

    test('case-insensitive when requested', () {
      expect(const Match('abc', caseSensitive: false).isValid('ABC'), isTrue);
    });

    test('does NOT trim the input', () {
      expect(const Match('abc').isValid(' abc '), isFalse);
    });

    test('empty matches empty', () {
      expect(const Match('').isValid(''), isTrue);
      expect(const Match('a').isValid(''), isFalse);
    });
  });

  group('MinLength', () {
    test('counts the trimmed length', () {
      expect(const MinLength(3).isValid('abc'), isTrue);
      expect(const MinLength(3).isValid('abcd'), isTrue);
      expect(const MinLength(3).isValid('ab'), isFalse);
      expect(const MinLength(3).isValid('  a  '), isFalse);
    });

    test('a minimum of zero accepts the empty string', () {
      expect(const MinLength(0).isValid(''), isTrue);
    });

    test('helper function mirrors the rule', () {
      expect(minLength('abc', 3), isTrue);
      expect(minLength('  ', 1), isFalse);
      expect(minLength(null, 3), isFalse);
    });
  });

  group('MaxLength', () {
    test('counts the trimmed length', () {
      expect(const MaxLength(3).isValid('abc'), isTrue);
      expect(const MaxLength(3).isValid('  abc  '), isTrue);
      expect(const MaxLength(3).isValid('abcd'), isFalse);
    });

    test('a maximum of zero accepts only empty/whitespace', () {
      expect(const MaxLength(0).isValid(''), isTrue);
      expect(const MaxLength(0).isValid('   '), isTrue);
      expect(const MaxLength(0).isValid('a'), isFalse);
    });
  });
}
