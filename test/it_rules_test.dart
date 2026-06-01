import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsEmail / isEmail', () {
    test('accepts well-formed addresses', () {
      expect(const IsEmail().isValid('test@example.com'), isTrue);
      expect(isEmail('a.b+tag@sub.domain.co'), isTrue);
      expect(isEmail('a@b.c'), isTrue);
    });

    test('rejects malformed addresses', () {
      expect(const IsEmail().isValid('plainaddress'), isFalse);
      expect(const IsEmail().isValid('@no-local.com'), isFalse);
      expect(const IsEmail().isValid('a@b'), isFalse); // top-level domain off
      expect(
        const IsEmail().isValid('user@123.456'),
        isFalse,
      ); // numeric domain
      expect(isEmail(null), isFalse);
      expect(isEmail(''), isFalse);
    });
  });

  group('IsBool / isBool', () {
    test('accepts true/false in any case, trimmed', () {
      expect(const IsBool().isValid('true'), isTrue);
      expect(const IsBool().isValid('false'), isTrue);
      expect(const IsBool().isValid(' FALSE '), isTrue);
      expect(const IsBool().isValid('TrUe'), isTrue);
    });

    test('rejects anything else', () {
      expect(const IsBool().isValid('yes'), isFalse);
      expect(const IsBool().isValid('1'), isFalse);
      expect(const IsBool().isValid('0'), isFalse);
      expect(const IsBool().isValid(''), isFalse);
      expect(const IsBool().isValid('truee'), isFalse);
    });

    test('free function also accepts actual bool values', () {
      expect(isBool(true), isTrue);
      expect(isBool(false), isTrue);
      expect(isBool(1), isFalse);
      expect(isBool(null), isFalse);
    });
  });

  group('IsPort / isPort', () {
    test('accepts the full 0..65535 range', () {
      expect(const IsPort().isValid('0'), isTrue);
      expect(const IsPort().isValid('1'), isTrue);
      expect(const IsPort().isValid('8080'), isTrue);
      expect(const IsPort().isValid('65535'), isTrue);
    });

    test('rejects out-of-range, non-integer and non-numeric input', () {
      expect(const IsPort().isValid('65536'), isFalse);
      expect(const IsPort().isValid('-1'), isFalse);
      expect(const IsPort().isValid('3.14'), isFalse);
      expect(const IsPort().isValid('abc'), isFalse);
      expect(const IsPort().isValid(''), isFalse);
    });

    test('free function accepts numeric values directly', () {
      expect(isPort(8080), isTrue);
      expect(isPort(65536), isFalse);
      expect(isPort(3.14), isFalse); // not an integer value
      expect(isPort(null), isFalse);
    });
  });

  group('IsIpAddress / isIpAddress', () {
    test('accepts valid IPv4 addresses', () {
      expect(const IsIpAddress().isValid('192.168.1.1'), isTrue);
      expect(const IsIpAddress().isValid('0.0.0.0'), isTrue);
      expect(const IsIpAddress().isValid('255.255.255.255'), isTrue);
    });

    test('rejects out-of-range octets and wrong shapes', () {
      expect(const IsIpAddress().isValid('256.1.1.1'), isFalse);
      expect(const IsIpAddress().isValid('1.2.3'), isFalse);
      expect(const IsIpAddress().isValid('1.2.3.4.5'), isFalse);
      expect(const IsIpAddress().isValid('1.2.3.x'), isFalse);
      expect(const IsIpAddress().isValid('-1.2.3.4'), isFalse);
      expect(const IsIpAddress().isValid('abc'), isFalse);
    });

    test('free function rejects null and non-strings', () {
      expect(isIpAddress(null), isFalse);
      expect(isIpAddress(123), isFalse);
    });

    // NOTE: octets are validated with int.parse, which tolerates leading zeros
    // and surrounding whitespace. So these "loose" forms currently pass.
    // Tightening to a strict dotted-quad regex is planned as a breaking change (v2).
    test(
      'tolerates leading zeros and whitespace around octets (known behavior)',
      () {
        expect(const IsIpAddress().isValid('192.168.001.001'), isTrue);
        expect(const IsIpAddress().isValid(' 192.168.1.1'), isTrue);
        expect(const IsIpAddress().isValid('192.168.1.1 '), isTrue);
        expect(const IsIpAddress().isValid('1 . 2 . 3 . 4'), isTrue);
      },
    );
  });

  group('RegExpRule', () {
    test('validates against an anchored pattern', () {
      final digits = RegExpRule(RegExp(r'^\d+$'));
      expect(digits.isValid('123'), isTrue);
      expect(digits.isValid('12a'), isFalse);
      expect(digits.isValid(''), isFalse);
    });

    test('an unanchored pattern matches anywhere (hasMatch semantics)', () {
      final hasDigit = RegExpRule(RegExp(r'\d'));
      expect(hasDigit.isValid('abc1'), isTrue);
      expect(hasDigit.isValid('abc'), isFalse);
    });
  });
}
