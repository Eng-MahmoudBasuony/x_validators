
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
