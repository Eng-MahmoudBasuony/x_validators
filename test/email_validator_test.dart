import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('EmailXValidator.validate', () {
    test('accepts common valid addresses', () {
      expect(EmailXValidator.validate('test@example.com'), isTrue);
      expect(
        EmailXValidator.validate('firstname.lastname@example.com'),
        isTrue,
      );
      expect(EmailXValidator.validate('email@subdomain.example.com'), isTrue);
      expect(EmailXValidator.validate('user+tag@example.com'), isTrue);
      expect(EmailXValidator.validate('user_name@example.co.uk'), isTrue);
      expect(EmailXValidator.validate('1234567890@example.com'), isTrue);
      expect(EmailXValidator.validate('a@b.c'), isTrue);
    });

    test('rejects malformed addresses', () {
      expect(EmailXValidator.validate(''), isFalse);
      expect(EmailXValidator.validate('plainaddress'), isFalse);
      expect(EmailXValidator.validate('@example.com'), isFalse);
      expect(EmailXValidator.validate('email@'), isFalse);
      expect(EmailXValidator.validate('email@@example.com'), isFalse);
      expect(
        EmailXValidator.validate('user@123.456'),
        isFalse,
      ); // numeric domain
    });

    test('does not trim surrounding whitespace', () {
      expect(EmailXValidator.validate(' test@example.com'), isFalse);
      expect(EmailXValidator.validate('test@example.com '), isFalse);
    });

    test('rejects addresses of 255+ characters', () {
      final longLocal = 'a' * 250;
      expect(EmailXValidator.validate('$longLocal@x.com'), isFalse);
    });

    test('top-level domains are rejected by default but opt-in works', () {
      expect(EmailXValidator.validate('email@example'), isFalse);
      expect(EmailXValidator.validate('email@example', true), isTrue);
    });

    // NOTE: allowInternational defaults to true, so non-ASCII local parts pass
    // unless explicitly disabled (third positional argument).
    test('international addresses are allowed by default', () {
      expect(EmailXValidator.validate('用户@example.com'), isTrue);
      expect(EmailXValidator.validate('用户@example.com', false, false), isFalse);
    });

    test('is stable across repeated calls (no leaked parser state)', () {
      for (var i = 0; i < 5; i++) {
        expect(EmailXValidator.validate('test@example.com'), isTrue);
        expect(EmailXValidator.validate('broken@'), isFalse);
      }
    });

    test('accepts quoted local parts', () {
      expect(EmailXValidator.validate('"john doe"@example.com'), isTrue);
      expect(EmailXValidator.validate('"john.doe"@example.com'), isTrue);
      expect(EmailXValidator.validate('"a"@b.com'), isTrue);
      expect(EmailXValidator.validate('""@example.com'), isTrue);
      // A backslash escapes the following quote, so the string stays open
      // until the real closing quote.
      expect(EmailXValidator.validate('"esc\\"quote"@example.com'), isTrue);
    });

    test('rejects an unterminated quoted local part', () {
      expect(EmailXValidator.validate('"john@example.com'), isFalse);
    });

    test('quoted local parts honor the allowInternational flag', () {
      expect(EmailXValidator.validate('"intlé"@example.com'), isTrue);
      expect(
        EmailXValidator.validate('"intlé"@example.com', false, false),
        isFalse,
      );
    });

    test('accepts bracketed IPv4 address literals', () {
      expect(EmailXValidator.validate('user@[192.168.1.1]'), isTrue);
      expect(EmailXValidator.validate('user@[127.0.0.1]'), isTrue);
    });

    test('rejects malformed IPv4 address literals', () {
      expect(EmailXValidator.validate('user@[999.1.1.1]'), isFalse); // > 255
      expect(EmailXValidator.validate('user@[1.2.3]'), isFalse); // 3 groups
      expect(EmailXValidator.validate('user@[192.168.1.1'), isFalse); // no ]
      expect(EmailXValidator.validate('user@[]'), isFalse); // too short
    });

    test('accepts bracketed IPv6 address literals', () {
      expect(EmailXValidator.validate('user@[IPv6:2001:db8::1]'), isTrue);
      expect(
        EmailXValidator.validate(
          'user@[IPv6:2001:0db8:0000:0000:0000:0000:0000:0001]',
        ),
        isTrue,
      );
    });

    test('rejects malformed IPv6 address literals', () {
      expect(EmailXValidator.validate('user@[IPv6:fe80::1'), isFalse); // no ]
      expect(EmailXValidator.validate('user@[IPv6:gggg::1]'), isFalse); // hex
    });

    test('handles the IPv6-with-embedded-IPv4 form', () {
      expect(
        EmailXValidator.validate('user@[IPv6:1:2:3:4:5:6:1.2.3.4]'),
        isTrue,
      ); // full
      expect(
        EmailXValidator.validate('user@[IPv6:::ffff:1.2.3.4]'),
        isTrue,
      ); // compact
      expect(
        EmailXValidator.validate('user@[IPv6:1:2:3:1.2.3.4]'),
        isFalse,
      ); // too few groups
    });
  });

  group('isEmail / IsEmail', () {
    test('the free function and rule wrap the validator', () {
      expect(isEmail('test@example.com'), isTrue);
      expect(isEmail(null), isFalse);
      expect(const IsEmail().isValid('test@example.com'), isTrue);
      expect(const IsEmail().isValid('a@b'), isFalse); // TLD off by default
    });
  });
}
