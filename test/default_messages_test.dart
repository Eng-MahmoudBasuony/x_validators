import 'package:test/test.dart' hide isEmpty, isNotEmpty, isIn;
import 'package:x_validators/x_validators.dart';

/// Each rule's `toString()` is the default message used as the final fallback
/// by [XValidatorsLocalization.translate] (after an inline `error` and any
/// registered translator). These tests lock that contract so the default
/// messages can't drift unnoticed.
void main() {
  group('default messages (toString)', () {
    test('colors', () {
      expect(const IsHexColor().toString(), 'must be hex color');
    });

    test('dates', () {
      expect(const IsDate().toString(), 'validation.is_not_date_format');
      expect(
        const IsDateMillis().toString(),
        'validation.not_valid_date_millis',
      );
      expect(
        IsDateAfter(DateTime(2020)).toString(),
        startsWith('must be after'),
      );
    });

    test('it', () {
      expect(const IsBool().toString(), 'validation.is_not_bool');
      expect(const IsEmail().toString(), 'validation.is_not_email_address');
      expect(const IsIpAddress().toString(), 'validation.is_ip_address');
      expect(const IsPort().toString(), 'validation.is_notport');
      expect(RegExpRule(RegExp('x')).toString(), 'validation.is_not_valid');
    });

    test('languages', () {
      expect(const IsArabicChars().toString(), 'validation.is_arabic_chars');
      expect(const IsEnglishChars().toString(), 'validation.is_english_chars');
      expect(const IsNumbersOnly().toString(), 'validation.is_numbers_only');
      expect(
        const IsLtrLanguage().toString(),
        'validation.is_not_ltr_language_code',
      );
      expect(
        const IsRTLLanguage().toString(),
        'validation.is_not_rtl_language_code',
      );
    });

    test('lists', () {
      expect(
        ContainsAny(const ['x']).toString(),
        'validation.must_contains_any',
      );
      expect(
        const NotContainsAny(['x']).toString(),
        'validation.must_not_contains_any',
      );
      expect(const IsIn(['x']).toString(), 'validation.must_be_in_list');
      expect(const IsNotIn(['x']).toString(), 'validation.must_not_be_in_list');
    });

    test('numbers', () {
      expect(const IsNumber().toString(), 'validation.must_be_int');
      expect(const IsArabicNum().toString(), 'validation.must_be_num');
      expect(const IsHindiNum().toString(), 'validation.must_be_num');
      expect(const MinValue(10).toString(), 'validation.must_be_min');
      expect(const MaxValue(10).toString(), 'validation.must_be_max');
    });

    test('phone', () {
      expect(const IsEgyptianPhone().toString(), 'validation.is_egyptian_num');
      expect(const ISKsaPhone().toString(), 'validation.is_ksa_num');
    });

    test('text', () {
      expect(const IsRequired().toString(), 'required');
      expect(const IsEmpty().toString(), 'validation.is_empty');
      expect(const Contains('x').toString(), 'validation.is_it_contains');
      expect(const NotContains('x').toString(), 'validation.not_contains');
      expect(const StartsWith('x').toString(), 'validation.starts_with');
      expect(const EndsWith('x').toString(), 'validation.must_end_with');
      expect(const Match('x').toString(), 'validation.should_match');
      expect(const MinLength(3).toString(), 'validation.min length is 3');
      expect(const MaxLength(3).toString(), 'validation.max length is 3');
    });

    test('urls', () {
      expect(const IsUrl().toString(), 'not_valid_url');
      expect(const IsSecureUrl().toString(), 'validation.is_not_secure_url');
      expect(const IsFacebookUrl().toString(), 'not_valid_facebook_url');
      expect(const IsInstagramUrl().toString(), 'not_valid_instagram_url');
      expect(const IsYoutubeUrl().toString(), 'not_valid_youtube_url');
    });

    test('IsOptional cannot produce a message — toString throws', () {
      expect(() => const IsOptional().toString(), throwsException);
    });
  });
}
