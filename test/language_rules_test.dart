import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsArabicChars / isArabicChars', () {
    test('accepts Arabic letters and whitespace', () {
      expect(const IsArabicChars().isValid('مرحبا'), isTrue);
      expect(const IsArabicChars().isValid('مرحبا أحمد'), isTrue);
    });

    test('accepts Arabic-Indic digits alongside letters', () {
      expect(const IsArabicChars().isValid('١٢٣'), isTrue);
      expect(const IsArabicChars().isValid('مرحبا ١٢٣'), isTrue);
    });

    test('rejects Latin letters and Latin digits', () {
      expect(const IsArabicChars().isValid('hello'), isFalse);
      expect(const IsArabicChars().isValid('a'), isFalse);
      expect(const IsArabicChars().isValid('123'), isFalse);
      expect(const IsArabicChars().isValid('مرحبا 123'), isFalse);
    });

    // Anchored in 2.0 to Arabic letters, whitespace and Arabic-Indic digits, so
    // the literal characters p, {, N and } no longer validate (they did before,
    // when `\p{N}` was parsed literally without the unicode flag).
    test('literal p { N } are rejected', () {
      expect(const IsArabicChars().isValid('p'), isFalse);
      expect(const IsArabicChars().isValid('{'), isFalse);
      expect(const IsArabicChars().isValid('N'), isFalse);
      expect(const IsArabicChars().isValid('}'), isFalse);
      expect(const IsArabicChars().isValid('pN{}'), isFalse);
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

    test('rejects strings that are not all digits', () {
      expect(const IsNumbersOnly().isValid('abc'), isFalse);
      expect(const IsNumbersOnly().isValid(''), isFalse);
    });

    // Anchored in 2.0 to `^[0-9]+$`: a digit somewhere in the string is no longer
    // enough — the whole value must be digits.
    test('mixed or spaced input is rejected', () {
      expect(const IsNumbersOnly().isValid('abc123'), isFalse);
      expect(const IsNumbersOnly().isValid('12 34'), isFalse);
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
