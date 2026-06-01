import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsHexColor / isHexColor', () {
    test('accepts 3-digit hex, with or without #', () {
      expect(const IsHexColor().isValid('fff'), isTrue);
      expect(const IsHexColor().isValid('ABC'), isTrue);
      expect(const IsHexColor().isValid('#abc'), isTrue);
      expect(const IsHexColor().isValid('#FFF'), isTrue);
    });

    test('accepts 6-digit hex, with or without #', () {
      expect(const IsHexColor().isValid('ffffff'), isTrue);
      expect(const IsHexColor().isValid('A1B2C3'), isTrue);
      expect(const IsHexColor().isValid('#ffffff'), isTrue);
    });

    test('accepts 8-digit hex (with alpha), with or without #', () {
      expect(const IsHexColor().isValid('ffffffff'), isTrue);
      expect(const IsHexColor().isValid('#12345678'), isTrue);
    });

    test('rejects unsupported lengths (1, 2, 4, 5, 7)', () {
      expect(const IsHexColor().isValid('f'), isFalse);
      expect(const IsHexColor().isValid('ff'), isFalse);
      expect(const IsHexColor().isValid('ffff'), isFalse);
      expect(const IsHexColor().isValid('12345'), isFalse);
      expect(const IsHexColor().isValid('1234567'), isFalse);
    });

    test('rejects non-hex characters and bad shapes', () {
      expect(const IsHexColor().isValid('xyz'), isFalse);
      expect(const IsHexColor().isValid('gggggg'), isFalse);
      expect(const IsHexColor().isValid('#ggg'), isFalse);
      expect(const IsHexColor().isValid('##fff'), isFalse);
      expect(const IsHexColor().isValid(''), isFalse);
    });

    test('free function handles null', () {
      expect(isHexColor('#fff'), isTrue);
      expect(isHexColor(null), isFalse);
    });
  });
}
