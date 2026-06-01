import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsDate / isDate', () {
    test('accepts the ISO-8601 forms DateTime.parse understands', () {
      expect(const IsDate().isValid('2024-01-01'), isTrue);
      expect(const IsDate().isValid('2024-01-01T10:30:00'), isTrue);
      expect(const IsDate().isValid('2024-01-01T10:30:00Z'), isTrue);
      expect(const IsDate().isValid('2024-01-01 10:30'), isTrue);
      expect(const IsDate().isValid('20240101'), isTrue);
    });

    test('rejects unparseable strings and non-ISO separators', () {
      expect(const IsDate().isValid('not a date'), isFalse);
      expect(const IsDate().isValid('2024/01/01'), isFalse);
      expect(const IsDate().isValid('01-01-2024'), isFalse);
      expect(isDate(null), isFalse);
      expect(isDate(''), isFalse);
    });

    // NOTE: DateTime normalizes out-of-range components, so an "impossible"
    // calendar date still parses (month 13 rolls into the next year, etc.).
    // Strict calendar validation is planned as a breaking change (v2).
    test('out-of-range calendar values still parse (known behavior)', () {
      expect(const IsDate().isValid('2024-13-01'), isTrue);
      expect(const IsDate().isValid('2024-02-30'), isTrue);
    });
  });

  group('IsDateMillis / isDateMills', () {
    test('accepts integer milliseconds since epoch (incl. zero/negative)', () {
      expect(const IsDateMillis().isValid('1700000000000'), isTrue);
      expect(const IsDateMillis().isValid('0'), isTrue);
      expect(const IsDateMillis().isValid('-5'), isTrue);
      expect(isDateMills('0'), isTrue);
    });

    test('rejects non-integer input', () {
      expect(const IsDateMillis().isValid('abc'), isFalse);
      expect(const IsDateMillis().isValid('3.14'), isFalse);
      expect(const IsDateMillis().isValid('1.0'), isFalse);
      expect(const IsDateMillis().isValid(''), isFalse);
    });

    test('honors the isUtc flag', () {
      expect(const IsDateMillis(isUtc: true).isValid('0'), isTrue);
      expect(isDateMills('0', isUtc: true), isTrue);
    });
  });

  group('IsDateAfter / isDateAfter', () {
    final rule = IsDateAfter(DateTime(2020, 1, 1));

    test('passes for a strictly later date', () {
      expect(rule.isValid('2021-06-15'), isTrue);
    });

    test('fails for an earlier date, the same date, or bad input', () {
      expect(rule.isValid('2019-06-15'), isFalse);
      expect(rule.isValid('2020-01-01'), isFalse); // not strictly after
      expect(rule.isValid('not a date'), isFalse);
    });

    test('free function accepts String or DateTime, rejects other input', () {
      expect(isDateAfter('2021-01-01', DateTime(2020)), isTrue);
      expect(isDateAfter(DateTime(2021), DateTime(2020)), isTrue);
      expect(isDateAfter(null, DateTime(2020)), isFalse);
      expect(isDateAfter(123, DateTime(2020)), isFalse);
    });

    test('defaultMessage is the date-after key', () {
      expect(
        IsDateAfter(DateTime(2020, 1, 1)).defaultMessage,
        'validation.is_not_date_after',
      );
    });
  });
}
