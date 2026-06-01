import 'package:test/test.dart';
import 'package:x_validators/x_validators.dart';

void main() {
  group('IsUrl / isUrlValid', () {
    test('accepts http(s) URLs with a host and TLD', () {
      expect(const IsUrl().isValid('https://www.example.com'), isTrue);
      expect(const IsUrl().isValid('http://example.org/path?q=1'), isTrue);
      expect(const IsUrl().isValid('https://example.com'), isTrue);
      expect(const IsUrl().isValid('http://a.bc'), isTrue);
    });

    test('accepts hyphens, deep subdomains and long TLDs', () {
      expect(const IsUrl().isValid('https://my-site.co.uk'), isTrue);
      expect(const IsUrl().isValid('https://a.b.example.com'), isTrue);
      expect(const IsUrl().isValid('https://example.museum'), isTrue);
      expect(const IsUrl().isValid('https://example.com:8080/p'), isTrue);
    });

    test('rejects a missing scheme, wrong scheme or bad shape', () {
      expect(const IsUrl().isValid('example.com'), isFalse);
      expect(const IsUrl().isValid('www.example.com'), isFalse);
      expect(const IsUrl().isValid('ftp://example.com'), isFalse);
      expect(const IsUrl().isValid('http://example'), isFalse); // no TLD
      expect(const IsUrl().isValid('https://'), isFalse);
      expect(const IsUrl().isValid('not a url'), isFalse);
    });

    test('free function mirrors the rule', () {
      expect(isUrlValid('https://example.com'), isTrue);
      expect(isUrlValid('nope'), isFalse);
    });
  });

  group('IsSecureUrl / isSecureUrl', () {
    test('accepts only the https:// scheme (case-insensitive)', () {
      expect(const IsSecureUrl().isValid('https://example.com'), isTrue);
      expect(const IsSecureUrl().isValid('HTTPS://EXAMPLE.COM'), isTrue);
      expect(const IsSecureUrl().isValid('http://example.com'), isFalse);
      expect(const IsSecureUrl().isValid('ftp://example.com'), isFalse);
      expect(const IsSecureUrl().isValid('example.com'), isFalse);
      expect(const IsSecureUrl().isValid(''), isFalse);
    });

    test('free function rejects null and non-strings', () {
      expect(isSecureUrl(null), isFalse);
      expect(isSecureUrl(123), isFalse);
    });

    // NOTE: this rule only checks the https:// prefix, NOT URL structure.
    test('only checks the prefix, not URL validity (known behavior)', () {
      expect(const IsSecureUrl().isValid('https://!!!not a url'), isTrue);
    });
  });

  group('Social URLs', () {
    test('IsFacebookUrl accepts facebook.com and fb.com', () {
      expect(
        const IsFacebookUrl().isValid('https://facebook.com/page'),
        isTrue,
      );
      expect(const IsFacebookUrl().isValid('https://www.fb.com/page'), isTrue);
      expect(const IsFacebookUrl().isValid('http://facebook.com'), isTrue);
      expect(
        const IsFacebookUrl().isValid('https://twitter.com/page'),
        isFalse,
      );
      expect(
        const IsFacebookUrl().isValid('facebook.com'),
        isFalse,
      ); // no scheme
    });

    test('IsInstagramUrl accepts instagram.com', () {
      expect(
        const IsInstagramUrl().isValid('https://instagram.com/user'),
        isTrue,
      );
      expect(
        const IsInstagramUrl().isValid('https://www.instagram.com'),
        isTrue,
      );
      expect(
        const IsInstagramUrl().isValid('https://example.com/user'),
        isFalse,
      );
    });

    test('IsYoutubeUrl accepts youtube.com', () {
      expect(
        const IsYoutubeUrl().isValid('https://www.youtube.com/watch?v=x'),
        isTrue,
      );
      expect(const IsYoutubeUrl().isValid('https://youtube.com'), isTrue);
      expect(const IsYoutubeUrl().isValid('https://vimeo.com/123'), isFalse);
    });

    // Anchored in 2.0: a matching host followed by extra labels (a classic
    // suffix spoof like facebook.com.evil.com) is now rejected.
    test('domain-suffix spoofing is rejected', () {
      expect(
        const IsFacebookUrl().isValid('https://facebook.com.evil.com'),
        isFalse,
      );
      expect(
        const IsInstagramUrl().isValid('https://instagram.com.evil.com'),
        isFalse,
      );
      expect(
        const IsYoutubeUrl().isValid('https://youtube.com.evil.com'),
        isFalse,
      );
    });
  });
}
