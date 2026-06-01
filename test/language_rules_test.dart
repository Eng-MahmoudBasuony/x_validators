import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsArabicChars / isArabicChars', () {
    test('accepts Arabic letters and whitespace', () {
      expect(const IsArabicChars().isValid('مرحبا'), isTrue);
      expect(const IsArabicChars().isValid('مرحبا أحمد'), isTrue);
    });

    test('rejects Latin letters and digits', () {
      expect(const IsArabicChars().isValid('hello'), isFalse);
      expect(const IsArabicChars().isValid('a'), isFalse);
      expect(const IsArabicChars().isValid('123'), isFalse);
      expect(const IsArabicChars().isValid('مرحبا 123'), isFalse);
    });

    // NOTE: the pattern is `^[ء-ي\s\p{N}]+$` WITHOUT the unicode flag,
    // so `\p{N}` is not the Unicode "Number" property — it is parsed as the
    // literal characters p, {, N and }. Those therefore validate as "Arabic",
    // while real digits do not. Fixing the class (unicode flag) is planned as a
    // breaking change (v2).
    test('literal p { N } slip through the \\p{N} bug (known behavior)', () {
      expect(const IsArabicChars().isValid('p'), isTrue);
      expect(const IsArabicChars().isValid('{'), isTrue);
      expect(const IsArabicChars().isValid('N'), isTrue);
      expect(const IsArabicChars().isValid('}'), isTrue);
      expect(const IsArabicChars().isValid('pN{}'), isTrue);
    });
  });

  group('IsEnglishChars / isEnglishChars', () {
    test('accepts ASCII letters in any case', () {
      expect(const IsEnglishChars().isValid('hello'), isTrue);
      expect(const IsEnglishChars().isValid('HELLO'), isTrue);
      expect(const IsEnglishChars().isValid('Hello'), isTrue);
    });

    test('rejects digits, spaces, punctuation and other scripts', () {
      expect(const IsEnglishChars().isValid('hello123'), isFalse);
      expect(const IsEnglishChars().isValid('hello world'), isFalse);
      expect(const IsEnglishChars().isValid('abc!'), isFalse);
      expect(const IsEnglishChars().isValid('مرحبا'), isFalse);
      expect(const IsEnglishChars().isValid(''), isFalse);
    });
  });

  group('IsNumbersOnly / isNumbersOnly', () {
    test('accepts digit strings', () {
      expect(const IsNumbersOnly().isValid('12345'), isTrue);
      expect(const IsNumbersOnly().isValid('0'), isTrue);
    });

    test('rejects strings with no digit at all', () {
      expect(const IsNumbersOnly().isValid('abc'), isFalse);
      expect(const IsNumbersOnly().isValid(''), isFalse);
    });

    // NOTE: despite the name, the regex `[0-9]` is unanchored, so it really
    // means "contains at least one digit". Anchoring to `^[0-9]+$` is planned
    // as a breaking change (v2).
    test('any input containing a digit currently matches (known behavior)', () {
      expect(const IsNumbersOnly().isValid('abc123'), isTrue);
      expect(const IsNumbersOnly().isValid('12 34'), isTrue);
    });
  });

  group('IsLtrLanguage / IsRTLLanguage / LanguageUtils', () {
    test('LTR detection (anything not in the RTL set is LTR)', () {
      expect(const IsLtrLanguage().isValid('en'), isTrue);
      expect(const IsLtrLanguage().isValid('fr'), isTrue);
      expect(const IsLtrLanguage().isValid('xyz'), isTrue);
      expect(const IsLtrLanguage().isValid('ar'), isFalse);
    });

    test('RTL detection covers ar/fa/he/ps/ur', () {
      expect(const IsRTLLanguage().isValid('ar'), isTrue);
      expect(const IsRTLLanguage().isValid('fa'), isTrue);
      expect(const IsRTLLanguage().isValid('he'), isTrue);
      expect(const IsRTLLanguage().isValid('ps'), isTrue);
      expect(const IsRTLLanguage().isValid('ur'), isTrue);
      expect(const IsRTLLanguage().isValid('en'), isFalse);
    });

    test('LanguageUtils helpers are case-insensitive', () {
      expect(LanguageUtils.isRtlLanguage('AR'), isTrue);
      expect(LanguageUtils.isLtrLanguage('en'), isTrue);
    });

    // NOTE: matching is on the exact (lower-cased) code, so locale variants
    // like `ar-EG` are NOT recognized as RTL.
    test('locale variants are not recognized (known behavior)', () {
      expect(const IsRTLLanguage().isValid('ar-EG'), isFalse);
    });
  });
}
