import 'package:test/test.dart' hide isEmpty, isNotEmpty, isIn;
import 'package:x_validators/x_validators.dart';

/// A legacy-style custom rule that supplies its message by overriding
/// `toString()` only (the pre-1.3 way). It must keep working because the base
/// [TextXValidationRule.defaultMessage] delegates to `toString()`.
class _LegacyToStringRule extends TextXValidationRule {
  const _LegacyToStringRule([super.error]);

  @override
  bool isValid(String input) => true;

  @override
  String toString() => 'legacy message';
}

/// Each rule's `defaultMessage` is the final fallback used by
/// [XValidatorsLocalization.translate] (after an inline `error` and any
/// registered translator). These tests lock that contract so the default
/// messages can't drift unnoticed.
void main() {
  group('default messages (defaultMessage)', () {
    test('colors', () {
      expect(const IsHexColor().defaultMessage, 'validation.is_not_hex_color');
    });

    test('dates', () {
      expect(const IsDate().defaultMessage, 'validation.is_not_date_format');
      expect(
        const IsDateMillis().defaultMessage,
        'validation.not_valid_date_millis',
      );
      expect(
        IsDateAfter(DateTime(2020)).defaultMessage,
        'validation.is_not_date_after',
      );
    });

    test('it', () {
      expect(const IsBool().defaultMessage, 'validation.is_not_bool');
      expect(const IsEmail().defaultMessage, 'validation.is_not_email_address');
      expect(const IsIpAddress().defaultMessage, 'validation.is_ip_address');
      expect(const IsPort().defaultMessage, 'validation.is_not_port');
      expect(RegExpRule(RegExp('x')).defaultMessage, 'validation.is_not_valid');
    });

    test('languages', () {
      expect(
        const IsArabicChars().defaultMessage,
        'validation.is_arabic_chars',
      );
      expect(
        const IsEnglishChars().defaultMessage,
        'validation.is_english_chars',
      );
      expect(
        const IsNumbersOnly().defaultMessage,
        'validation.is_numbers_only',
      );
      expect(
        const IsLtrLanguage().defaultMessage,
        'validation.is_not_ltr_language_code',
      );
      expect(
        const IsRTLLanguage().defaultMessage,
        'validation.is_not_rtl_language_code',
      );
    });

    test('lists', () {
      expect(
        ContainsAny(const ['x']).defaultMessage,
        'validation.must_contains_any',
      );
      expect(
        const NotContainsAny(['x']).defaultMessage,
        'validation.must_not_contains_any',
      );
      expect(const IsIn(['x']).defaultMessage, 'validation.must_be_in_list');
      expect(
        const IsNotIn(['x']).defaultMessage,
        'validation.must_not_be_in_list',
      );
    });

    test('numbers', () {
      expect(const IsNumber().defaultMessage, 'validation.must_be_int');
      expect(const IsDecimal().defaultMessage, 'validation.must_be_double');
      expect(
        const IsArabicNum().defaultMessage,
        'validation.must_be_arabic_num',
      );
      expect(const IsHindiNum().defaultMessage, 'validation.must_be_hindi_num');
      expect(const MinValue(10).defaultMessage, 'validation.must_be_min');
      expect(const MaxValue(10).defaultMessage, 'validation.must_be_max');
    });

    test('phone', () {
      expect(
        const IsEgyptianPhone().defaultMessage,
        'validation.is_egyptian_num',
      );
      expect(const ISKsaPhone().defaultMessage, 'validation.is_ksa_num');
    });

    test('text', () {
      expect(const IsRequired().defaultMessage, 'validation.is_required');
      expect(const IsEmpty().defaultMessage, 'validation.is_empty');
      expect(const Contains('x').defaultMessage, 'validation.is_it_contains');
      expect(const NotContains('x').defaultMessage, 'validation.not_contains');
      expect(const StartsWith('x').defaultMessage, 'validation.starts_with');
      expect(const EndsWith('x').defaultMessage, 'validation.must_end_with');
      expect(const Match('x').defaultMessage, 'validation.should_match');
      expect(const MinLength(3).defaultMessage, 'validation.min_length');
      expect(const MaxLength(3).defaultMessage, 'validation.max_length');
    });

    test('urls', () {
      expect(const IsUrl().defaultMessage, 'validation.is_not_url');
      expect(
        const IsSecureUrl().defaultMessage,
        'validation.is_not_secure_url',
      );
      expect(
        const IsFacebookUrl().defaultMessage,
        'validation.is_not_facebook_url',
      );
      expect(
        const IsInstagramUrl().defaultMessage,
        'validation.is_not_instagram_url',
      );
      expect(
        const IsYoutubeUrl().defaultMessage,
        'validation.is_not_youtube_url',
      );
    });

    test('IsOptional carries no message — it always validates', () {
      expect(const IsOptional().isValid('anything'), isTrue);
    });
  });

  group('defaultMessage fallback chain', () {
    test('base defaultMessage delegates to toString() for legacy rules', () {
      const rule = _LegacyToStringRule();
      expect(rule.defaultMessage, 'legacy message');
      expect(XValidatorsLocalization.translate(rule), 'legacy message');
    });

    test(
      'translate() returns the defaultMessage when no translator is set',
      () {
        expect(
          XValidatorsLocalization.translate(const IsEmpty()),
          'validation.is_empty',
        );
      },
    );
  });
}
