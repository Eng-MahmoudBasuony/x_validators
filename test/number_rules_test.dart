import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsNumber / isNumber', () {
    test('accepts integers, including signed and zero', () {
      expect(const IsNumber().isValid('0'), isTrue);
      expect(const IsNumber().isValid('123'), isTrue);
      expect(const IsNumber().isValid('-5'), isTrue);
      expect(const IsNumber().isValid('+5'), isTrue);
      expect(const IsNumber().isValid('00'), isTrue);
    });

    test('trims surrounding whitespace', () {
      expect(const IsNumber().isValid(' 5 '), isTrue);
    });

    test('rejects clearly non-numeric input', () {
      expect(const IsNumber().isValid('abc'), isFalse);
      expect(const IsNumber().isValid(''), isFalse);
      expect(const IsNumber().isValid('1 000'), isFalse);
      expect(const IsNumber().isValid('3.1.4'), isFalse);
      expect(isNumber(null), isFalse);
    });

    // 2.0 narrowed this from num.tryParse to int.tryParse, so non-integers that
    // used to pass are now rejected. Use IsDecimal for fractional values.
    test('rejects decimals, hex, scientific and specials', () {
      expect(const IsNumber().isValid('3.14'), isFalse);
      expect(const IsNumber().isValid('.5'), isFalse);
      expect(const IsNumber().isValid('5.'), isFalse);
      expect(const IsNumber().isValid('1e3'), isFalse);
      expect(const IsNumber().isValid('0x1A'), isFalse);
      expect(const IsNumber().isValid('NaN'), isFalse);
      expect(const IsNumber().isValid('Infinity'), isFalse);
    });
  });

  group('IsDecimal / isDecimal', () {
    test('accepts integers and decimals, signed', () {
      expect(const IsDecimal().isValid('5'), isTrue);
      expect(const IsDecimal().isValid('3.14'), isTrue);
      expect(const IsDecimal().isValid('-2.5'), isTrue);
      expect(const IsDecimal().isValid('.5'), isTrue);
      expect(const IsDecimal().isValid('1e3'), isTrue);
      expect(const IsDecimal().isValid(' 5 '), isTrue);
    });

    test('rejects non-numeric input', () {
      expect(const IsDecimal().isValid('abc'), isFalse);
      expect(const IsDecimal().isValid(''), isFalse);
      expect(const IsDecimal().isValid('1.2.3'), isFalse);
      expect(isDecimal(null), isFalse);
    });
  });

  group(
    'IsArabicNum / isArabicNum (Latin digits, positive, no leading zero)',
    () {
      test('accepts a positive integer in Latin digits', () {
        expect(const IsArabicNum().isValid('5'), isTrue);
        expect(const IsArabicNum().isValid('123'), isTrue);
        expect(isArabicNum('900'), isTrue);
      });

      test('rejects leading zero, zero, signs, decimals and non-digits', () {
        expect(const IsArabicNum().isValid('0'), isFalse);
        expect(const IsArabicNum().isValid('01'), isFalse);
        expect(const IsArabicNum().isValid('00'), isFalse);
        expect(const IsArabicNum().isValid('-5'), isFalse);
        expect(const IsArabicNum().isValid('3.14'), isFalse);
        expect(const IsArabicNum().isValid(''), isFalse);
        expect(const IsArabicNum().isValid('abc'), isFalse);
      });

      test('rejects Arabic-Indic digits', () {
        expect(const IsArabicNum().isValid('١٢٣'), isFalse);
      });
    },
  );

  group('IsHindiNum / isHindiNum (Arabic-Indic digits ٠-٩, no leading ٠)', () {
    test('accepts Arabic-Indic digits', () {
      expect(const IsHindiNum().isValid('١'), isTrue);
      expect(const IsHindiNum().isValid('١٢٣'), isTrue);
      expect(const IsHindiNum().isValid('٩٠'), isTrue);
    });

    test('rejects a leading zero and Latin digits', () {
      expect(const IsHindiNum().isValid('٠'), isFalse);
      expect(const IsHindiNum().isValid('٠١'), isFalse);
      expect(const IsHindiNum().isValid('123'), isFalse);
      expect(const IsHindiNum().isValid(''), isFalse);
    });
  });

  group('MinValue / minValue', () {
    test('compares the parsed value (inclusive)', () {
      expect(const MinValue(10).isValid('15'), isTrue);
      expect(const MinValue(10).isValid('10'), isTrue);
      expect(const MinValue(10).isValid('5'), isFalse);
    });

    test('supports fractional bounds', () {
      expect(const MinValue(1.5).isValid('2'), isTrue);
      expect(const MinValue(1.5).isValid('1'), isFalse);
    });

    test('non-numeric input fails', () {
      expect(const MinValue(0).isValid('abc'), isFalse);
      expect(const MinValue(0).isValid(''), isFalse);
      expect(minValue('15', 10), isTrue);
      expect(minValue('abc', 10), isFalse);
    });

    test('the free function also accepts raw num values', () {
      expect(minValue(5, 3), isTrue);
      expect(minValue(2, 3), isFalse);
      expect(minValue(3.5, 3), isTrue);
      expect(minValue(null, 3), isFalse);
      expect(minValue(true, 3), isFalse); // unsupported type
    });
  });

  group('MaxValue / maxValue', () {
    test('compares the parsed value (inclusive)', () {
      expect(const MaxValue(10).isValid('5'), isTrue);
      expect(const MaxValue(10).isValid('10'), isTrue);
      expect(const MaxValue(10).isValid('15'), isFalse);
    });

    test('supports fractional bounds', () {
      expect(const MaxValue(1.5).isValid('1'), isTrue);
      expect(const MaxValue(1.5).isValid('2'), isFalse);
    });

    test('non-numeric input fails', () {
      expect(const MaxValue(10).isValid('abc'), isFalse);
      expect(maxValue('5', 10), isTrue);
      expect(maxValue('abc', 10), isFalse);
    });

    test('the free function also accepts raw num values', () {
      expect(maxValue(5, 10), isTrue);
      expect(maxValue(11, 10), isFalse);
      expect(maxValue(2.5, 10), isTrue);
      expect(maxValue(null, 10), isFalse);
      expect(maxValue(true, 10), isFalse); // unsupported type
    });
  });
}
