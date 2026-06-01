import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsEgyptianPhone / isEgyptianNumber', () {
    test('accepts the four valid mobile prefixes (010/011/012/015)', () {
      expect(const IsEgyptianPhone().isValid('01012345678'), isTrue);
      expect(const IsEgyptianPhone().isValid('01112345678'), isTrue);
      expect(const IsEgyptianPhone().isValid('01212345678'), isTrue);
      expect(const IsEgyptianPhone().isValid('01512345678'), isTrue);
      expect(isEgyptianNumber('01012345678'), isTrue);
    });

    test('rejects invalid third digit (013/014)', () {
      expect(const IsEgyptianPhone().isValid('01312345678'), isFalse);
      expect(const IsEgyptianPhone().isValid('01412345678'), isFalse);
    });

    test('rejects wrong length, wrong start and non-digits', () {
      expect(
        const IsEgyptianPhone().isValid('0101234567'),
        isFalse,
      ); // 10 digits
      expect(
        const IsEgyptianPhone().isValid('010123456789'),
        isFalse,
      ); // 12 digits
      expect(const IsEgyptianPhone().isValid('11012345678'), isFalse); // no 01
      expect(const IsEgyptianPhone().isValid('0101234567a'), isFalse);
      expect(const IsEgyptianPhone().isValid(''), isFalse);
    });
  });

  group('ISKsaPhone / isKsaPhone', () {
    test('accepts the supported local and international prefixes', () {
      expect(const ISKsaPhone().isValid('551234567'), isTrue); // 5 + digit + 7
      expect(const ISKsaPhone().isValid('0551234567'), isTrue); // 05 prefix
      expect(const ISKsaPhone().isValid('966551234567'), isTrue); // 9665 prefix
      expect(const ISKsaPhone().isValid('+966551234567'), isTrue);
      expect(const ISKsaPhone().isValid('00966551234567'), isTrue);
      expect(isKsaPhone('0551234567'), isTrue);
    });

    test('rejects wrong length and clearly invalid input', () {
      expect(const ISKsaPhone().isValid('12345'), isFalse);
      expect(const ISKsaPhone().isValid('5551234567'), isFalse); // too long
      expect(const ISKsaPhone().isValid('blah'), isFalse);
      expect(const ISKsaPhone().isValid(''), isFalse);
    });

    // NOTE: the carrier digit (right after the prefix) must be one of
    // 5,0,3,6,4,9,1,8,7 — '2' is the only digit the pattern rejects there.
    test("rejects '2' as the carrier digit (known pattern detail)", () {
      expect(const ISKsaPhone().isValid('0521234567'), isFalse);
    });
  });
}
