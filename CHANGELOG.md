
## [1.0.0]-[2-1-2024] initial version

- initial version

## [1.0.1]-[2-1-2024] initial version

- fix readme

## [1.0.2]-[8-1-2024] Update README

- refactor:♻️ 🗑️ Improve code readability

## [1.0.3]-[8-1-2024] Update README

- fix readme

## [1.0.4]-[8-1-2024] Update README

- refactor:♻️ 🗑️ Improve code readability
- docs:📝 Update README

## [1.0.5]-[11-1-2024] fix

- refactor:♻️ 🗑️ Improve code readability
- docs:📝 Update README
- fix: 🛠️🐞Fixed the Bug with v1.0.4

## [1.0.6]-[11-1-2024] Update README

- refactor:♻️ 🗑️ Improve code readability

## [1.0.7]-[11-1-2024] Update DOC

- docs:📝 Update Doc

## [1.0.8]-[21-04-2024] Update DOC 

- docs:📝 Update Doc (Support Palestine)

## [1.1.0]-[01-06-2026] Exports, consistency & full test suite

- fix: 🐞 Export previously-unreachable rules (`IsIpAddress`, `IsSecureUrl`, `IsArabicChars`, `IsEnglishChars`, `IsNumbersOnly`)
- fix: 🐞 Export the `XValidatorsLocalization` hook so custom error-message translation is usable by consumers
- feat: ✨ Add `const` constructors across all rules for cleaner, allocation-free usage
- test: ✅ Add a comprehensive unit-test suite covering every rule and the `xValidator` orchestrator
- docs:📝 Rewrite the README with accurate API tables, localization and custom-rule guides
- chore: 🧹 Resolve all `dart analyze` issues

## [1.2.0]-[01-06-2026] Docs, full coverage & SDK bump

- chore: ⬆️ Raise the minimum Dart SDK to `^3.8.0`
- docs: 📝 Add dartdoc across the public rule API (classes and validation functions) and fix several inaccurate/typo'd doc strings
- test: ✅ Expand the suite to 100% line coverage (149 tests): quoted & IP-literal (IPv4/IPv6) email parsing, default-message (`toString`) contracts, numeric `min`/`max` raw-`num` paths, and `containsAny` trim/case flags
- chore: ⬆️ Bump the example app to `flutter_lints` `^6.0.0`
- style: 🎨 Adopt the Dart "tall" formatting style

## [1.3.0]-[01-06-2026] Message API, key cleanup, RegExp hoisting & IsOptional fix

- feat: ✨ Add a dedicated `defaultMessage` getter as the message API for rules; the base implementation delegates to `toString()`, so existing custom rules that override `toString()` keep working unchanged
- fix: 🐞 `IsOptional` is now honored regardless of its position in the rule list — optionality is resolved by an up-front scan, fixing the case where an empty value wrongly failed when `IsOptional` was placed after another rule
- fix: 🐞 Normalize malformed/typo'd default-message keys to stable `validation.*` keys (`is_notport` → `is_not_port`, hex-color, date-after, min/max length, url, facebook/instagram/youtube url, required); consumers using an inline `error:` or a registered translator are unaffected
- perf: ⚡ Hoist per-call `RegExp`s to top-level `final` constants (compiled once) across the phone, language, number, url and color rules, and collapse the hex-color check from two patterns into one
- refactor: ♻️ Remove dead branches in `match`, `minValue` and `maxValue`
- chore: 🗑️ Deprecate the no-op `ContainsAny.caseSensitive` field (currently ignored; it will be wired up as a constructor parameter in v2.0.0)
- test: ✅ Migrate the default-message contracts to `defaultMessage`, add an `IsOptional` position-independence regression and `defaultMessage` fallback-chain coverage (152 tests)

## [2.0.0]-[01-06-2026] Breaking: behavior corrections & tightened rules

This is a behavior-only major release. The public API shape is unchanged (same
rules, same `xValidator` signature); several rules were tightened to match their
names. See the **Migrating to 2.0.0** guide in the README for adaptation steps.

- **BREAKING** fix: 🐞 `null` input is now treated as an empty string instead of short-circuiting the validator to "valid", so `IsRequired` correctly rejects `null`; add `IsOptional` to let empty/`null` pass
- **BREAKING** fix: 🐞 `IsNumber` now accepts integers only (decimals, hex and scientific notation are rejected) — use the new `IsDecimal` rule for fractional values
- **BREAKING** feat: ✨ Add `IsDecimal` rule + `isDecimal` helper (backed by `double.tryParse`, key `validation.must_be_double`) for fractional-number validation
- **BREAKING** fix: 🐞 `IsArabicChars` now accepts Arabic-Indic digits `٠-٩` only; the previous `\p{N}` token (no unicode flag) matched the literal characters `p{N}` and no real digits
- **BREAKING** fix: 🐞 `IsNumbersOnly` is now anchored (`^[0-9]+$`) and passes only when the whole input is digits, instead of passing whenever a digit appeared anywhere
- **BREAKING** fix: 🔒 Anchor `IsFacebookUrl`, `IsInstagramUrl` and `IsYoutubeUrl` so domain-suffix spoofing (e.g. `https://facebook.com.evil.com`) is rejected
- **BREAKING** fix: 🔒 `IsIpAddress` now uses a strict dotted-quad regex — leading zeros (`192.168.001.001`) and surrounding/embedded whitespace are rejected
- **BREAKING** fix: 🐞 Wire up `ContainsAny.caseSensitive` as a real constructor parameter; `error` moves from a positional to a named argument (`ContainsAny(values, {caseSensitive = false, error})`)
- **BREAKING** fix: 🐞 Give `IsArabicNum` and `IsHindiNum` distinct default-message keys (`validation.must_be_arabic_num` / `validation.must_be_hindi_num`) instead of the shared `validation.must_be_num`
- feat: ✨ Broaden `IsUrl` to accept hyphenated hosts, deep subdomains and long TLDs (`https://my-site.co.uk`, `https://a.b.example.com`, `https://example.museum`)
- refactor: ♻️ Remove static mutable parser state from `EmailXValidator`; each `validate` call now runs on a fresh single-use parser (public signature and behavior unchanged)
- refactor: ♻️ Rename the typo'd `isInstgramUrlValid` helper to `isInstagramUrlValid` (old name kept as a `@Deprecated` alias) and the files `text/is_not_empty.dart` → `text/is_required.dart` and `urls/is_instgram_url.dart` → `urls/is_instagram_url.dart`
- docs: 📝 Add a "Migrating to 2.0.0" guide and update the API tables, localization resolution order and "Good to know" notes
- test: ✅ Update and extend the suite for every behavior change (new `IsDecimal` and strict-IP groups, flipped known-behavior cases)
