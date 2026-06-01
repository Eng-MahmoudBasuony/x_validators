[![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)](https://thebsd.github.io/StandWithPalestine)

<p align="center">
  <a href="#"><img src="https://raw.githubusercontent.com/Eng-MahmoudBasuony/x_validators/main/logo_x_validators.png" width=350 height=auto /></a>
</p>

# ☕ X Validators

[![Pub Version](https://img.shields.io/pub/v/x_validators)](https://pub.dev/packages/x_validators)
[![License](https://img.shields.io/github/license/Eng-MahmoudBasuony/x_validators)](https://github.com/Eng-MahmoudBasuony/x_validators/blob/main/LICENSE)

The simplest way to validate Flutter form fields — a small, composable set of rules
that plug straight into any `TextFormField.validator`.

- ✅ **Zero dependencies** — pure Dart, nothing to ship but your code
- 🧩 **Composable** — stack rules; the first failure wins
- 🔌 **Extensible** — write your own rule by implementing one method
- 🌍 **Localizable** — translate every error message per rule type
- 🧪 **Well tested** — every rule is covered by unit tests

## Table of Contents

- [Installation](#-installation)
- [Quick start](#-quick-start)
- [How it works](#-how-it-works)
- [API reference](#-api-reference)
- [Examples for every rule](#examples-for-every-rule)
- [Usage guide](#-usage-guide)
  - [Composing rules](#composing-rules)
  - [Real-world recipes](#real-world-recipes)
  - [Custom error messages](#custom-error-messages)
  - [Reacting to failures](#reacting-to-failures-onfailurecallback)
  - [Optional fields](#optional-fields)
  - [Writing a custom rule](#writing-a-custom-rule)
  - [Localizing error messages](#localizing-error-messages)
  - [Standalone helper functions](#standalone-helper-functions)
- [Good to know](#-good-to-know)
- [Migrating to 2.0.0](#migrating-to-200)
- [License](#-license)

## 🚀 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  x_validators: ^2.0.0
```

Then run `flutter pub get` (or `dart pub get`).

```dart
import 'package:x_validators/x_validators.dart';
```

## ⚡ Quick start

`xValidator` takes a list of rules and returns a `String? Function(String?)` —
exactly the signature Flutter's form fields expect:

```dart
TextFormField(
  decoration: const InputDecoration(labelText: 'Email'),
  validator: xValidator([
    const IsRequired(),
    const IsEmail(),
  ]),
);
```

The returned function yields `null` when the value is valid, or the error message
of the **first** failing rule otherwise.

## 🧠 How it works

Every rule is a small class that extends `TextXValidationRule` and answers one
question — `bool isValid(String input)`. `xValidator` runs the rules **in order**
and stops at the first one that fails:

```
xValidator([ rule₁, rule₂, rule₃ ])  ──▶  String? Function(String? value)
                                              │
        value ─▶ rule₁.isValid? ─ yes ─▶ rule₂.isValid? ─ yes ─▶ rule₃ ... ─▶ null  (valid)
                      │ no                     │ no
                      ▼                        ▼
                  error message            error message            (first failure wins)
```

Because order matters, put broad rules first (e.g. `IsRequired`) and specific
rules after (e.g. `IsEmail`).

## 📚 API reference

Most rules accept an optional positional `error` message as their **last**
argument (e.g. `IsRequired('This field is required')`); a few (`Match`,
`ContainsAny`) take it as a named `error` parameter alongside their other named
options. When omitted, the rule's default message is used (see
[Localizing error messages](#localizing-error-messages)).

#### Text

| Rule | Description |
|------|-------------|
| `IsRequired([error])` | Fails when the trimmed input is empty. |
| `IsEmpty([error])` | Passes only when the trimmed input is empty. |
| `Contains(value, [error])` | Input contains `value` (compared after trimming). |
| `NotContains(value, [error])` | Input does **not** contain `value`. |
| `StartsWith(prefix, [error])` | Input starts with `prefix`. |
| `EndsWith(suffix, [error])` | Input ends with `suffix`. |
| `Match(value, {caseSensitive = true}, [error])` | Input equals `value`; case-insensitive when `caseSensitive` is `false`. |
| `MinLength(min, [error])` | Trimmed length is `>= min`. |
| `MaxLength(max, [error])` | Trimmed length is `<= max`. |

#### Numbers

| Rule | Description |
|------|-------------|
| `IsNumber([error])` | Input is an integer (use `IsDecimal` for fractional values). |
| `IsDecimal([error])` | Input is a decimal number (integers are accepted too). |
| `IsArabicNum([error])` | Positive integer written in Latin digits `0-9` (no leading zero). |
| `IsHindiNum([error])` | Number written in Arabic-Indic digits `٠-٩`. |
| `MinValue(min, [error])` | Parsed numeric value is `>= min`. |
| `MaxValue(max, [error])` | Parsed numeric value is `<= max`. |

#### URLs

| Rule | Description |
|------|-------------|
| `IsUrl([error])` | Input is a valid `http`/`https` URL. |
| `IsSecureUrl([error])` | Input is a URL using the `https://` scheme. |
| `IsFacebookUrl([error])` | Input is a valid Facebook URL. |
| `IsInstagramUrl([error])` | Input is a valid Instagram URL. |
| `IsYoutubeUrl([error])` | Input is a valid YouTube URL. |

#### Phone

| Rule | Description |
|------|-------------|
| `IsEgyptianPhone([error])` | Input is a valid Egyptian phone number. |
| `ISKsaPhone([error])` | Input is a valid Saudi Arabian phone number. |

#### IT

| Rule | Description |
|------|-------------|
| `IsEmail([error])` | Input is a valid email address. |
| `IsBool([error])` | Input is a valid boolean value. |
| `IsIpAddress([error])` | Input is a valid IP address. |
| `IsPort([error])` | Input is a valid port number. |
| `RegExpRule(regExp, [error])` | Input matches the provided `RegExp`. |

#### Lists

| Rule | Description |
|------|-------------|
| `IsIn(values, [error])` | Input is one of the values in the provided list. |
| `IsNotIn(values, [error])` | Input is **not** in the provided list. |
| `ContainsAny(values, {caseSensitive = false, error})` | Input contains at least one item from the list (case-insensitive by default). |
| `NotContainsAny(values, [error])` | Input contains none of the items in the list. |

#### Dates

| Rule | Description |
|------|-------------|
| `IsDate([error])` | Input is a parseable date string. |
| `IsDateMillis([error])` | Input is an integer of milliseconds since epoch. |
| `IsDateAfter(date, [error])` | Input is a date later than `date`. |

#### Languages

| Rule | Description |
|------|-------------|
| `IsArabicChars([error])` | Input consists of Arabic letters, whitespace and Arabic-Indic digits `٠-٩`. |
| `IsEnglishChars([error])` | Only English letters `A–Z` (no spaces or digits). |
| `IsNumbersOnly([error])` | Input is all digits (one or more). |
| `IsLtrLanguage([error])` | Input is a left-to-right language code. |
| `IsRTLLanguage([error])` | Input is a right-to-left language code. |

#### Colors

| Rule | Description |
|------|-------------|
| `IsHexColor([error])` | Input is a valid 3/6/8-digit hex color. |

#### Magic

| Rule | Description |
|------|-------------|
| `IsOptional()` | When present, an **empty** field skips all other rules and passes. |

## Examples for every rule

Every rule is shown below with a passing and a failing input. The examples use
`rule.isValid(value)` so you can see the boolean directly; inside a form you'd
normally pass the rule to `xValidator([...])` and get the error message instead
(see [Composing rules](#composing-rules)). Each rule also has a matching
top-level function (`isEmail`, `isHexColor`, …) for one-off checks — see
[Standalone helper functions](#standalone-helper-functions).

### Text

```dart
const IsRequired().isValid('Jane');           // → true
const IsRequired().isValid('   ');            // → false  (trimmed empty)

const IsEmpty().isValid('   ');               // → true
const IsEmpty().isValid('x');                 // → false

const Contains('@').isValid('a@b.com');       // → true
const Contains('@').isValid('abc');           // → false

const NotContains(' ').isValid('no_spaces');  // → true
const NotContains(' ').isValid('has space');  // → false

const StartsWith('+20').isValid('+20100');    // → true
const StartsWith('+20').isValid('0100');      // → false

const EndsWith('.com').isValid('site.com');   // → true
const EndsWith('.com').isValid('site.org');   // → false

const Match('Yes').isValid('Yes');            // → true   (case-sensitive by default)
const Match('Yes').isValid('yes');            // → false
const Match('Yes', caseSensitive: false).isValid('yes'); // → true

const MinLength(3).isValid('abc');            // → true
const MinLength(3).isValid('ab');             // → false

const MaxLength(5).isValid('abcde');          // → true
const MaxLength(5).isValid('abcdef');         // → false
```

### Numbers

```dart
const IsNumber().isValid('42');               // → true
const IsNumber().isValid('-7');               // → true
const IsNumber().isValid('3.14');             // → false  (use IsDecimal)
const IsNumber().isValid('0x1A');             // → false  (no hex)

const IsDecimal().isValid('3.14');            // → true
const IsDecimal().isValid('42');              // → true   (integers too)
const IsDecimal().isValid('abc');             // → false

const IsArabicNum().isValid('123');           // → true   (Latin digits, positive)
const IsArabicNum().isValid('012');           // → false  (leading zero)
const IsArabicNum().isValid('0');             // → false

const IsHindiNum().isValid('١٢٣');             // → true   (Arabic-Indic digits)
const IsHindiNum().isValid('٠١٢');             // → false  (leading ٠)
const IsHindiNum().isValid('123');            // → false  (Latin digits)

const MinValue(18).isValid('18');             // → true
const MinValue(18).isValid('17');             // → false

const MaxValue(100).isValid('100');           // → true
const MaxValue(100).isValid('101');           // → false
```

### URLs

```dart
const IsUrl().isValid('https://my-site.co.uk');         // → true
const IsUrl().isValid('https://a.b.example.com/p?x=1'); // → true
const IsUrl().isValid('example.com');                   // → false  (no scheme)

const IsSecureUrl().isValid('https://x.com');           // → true
const IsSecureUrl().isValid('http://x.com');            // → false

const IsFacebookUrl().isValid('https://facebook.com/me');       // → true
const IsFacebookUrl().isValid('https://facebook.com.evil.com'); // → false

const IsInstagramUrl().isValid('https://instagram.com/me');     // → true
const IsInstagramUrl().isValid('https://evil.com');             // → false

const IsYoutubeUrl().isValid('https://youtube.com/watch?v=x');  // → true
const IsYoutubeUrl().isValid('https://vimeo.com/1');            // → false
```

### Phone

```dart
const IsEgyptianPhone().isValid('01012345678'); // → true   (010/011/012/015 + 8 digits)
const IsEgyptianPhone().isValid('01312345678'); // → false  (013 is not a valid prefix)

const ISKsaPhone().isValid('0512345678');       // → true
const ISKsaPhone().isValid('+966512345678');    // → true
const ISKsaPhone().isValid('0612345678');       // → false
```

### IT

```dart
const IsEmail().isValid('jane.doe@example.com'); // → true
const IsEmail().isValid('plainaddress');         // → false

const IsBool().isValid('true');                  // → true
const IsBool().isValid(' FALSE ');               // → true   (trimmed, case-insensitive)
const IsBool().isValid('yes');                   // → false

const IsIpAddress().isValid('192.168.1.1');      // → true
const IsIpAddress().isValid('192.168.001.001');  // → false  (leading zeros)

const IsPort().isValid('8080');                  // → true   (0–65535)
const IsPort().isValid('65536');                 // → false

RegExpRule(RegExp(r'^[A-Z]{3}$')).isValid('EGP'); // → true
RegExpRule(RegExp(r'^[A-Z]{3}$')).isValid('usd'); // → false
```

### Lists

```dart
const IsIn(['red', 'green', 'blue']).isValid('green');  // → true
const IsIn(['red', 'green', 'blue']).isValid('yellow'); // → false

const IsNotIn(['admin', 'root']).isValid('guest');      // → true
const IsNotIn(['admin', 'root']).isValid('admin');      // → false

const ContainsAny(['http', 'https']).isValid('https://x'); // → true
const ContainsAny(['http', 'https']).isValid('ftp://x');   // → false
const ContainsAny(['USD']).isValid('usd ok');                      // → true   (case-insensitive)
const ContainsAny(['USD'], caseSensitive: true).isValid('usd ok'); // → false

const NotContainsAny(['<', '>']).isValid('safe'); // → true
const NotContainsAny(['<', '>']).isValid('a<b');  // → false
```

### Dates

```dart
const IsDate().isValid('2026-06-01'); // → true
const IsDate().isValid('not-a-date'); // → false

const IsDateMillis().isValid('1700000000000'); // → true
const IsDateMillis().isValid('3.14');          // → false

IsDateAfter(DateTime(2020)).isValid('2026-01-01'); // → true
IsDateAfter(DateTime(2020)).isValid('2019-01-01'); // → false
```

### Languages

```dart
const IsArabicChars().isValid('مرحبا بك');  // → true
const IsArabicChars().isValid('مرحبا ١٢٣'); // → true   (Arabic-Indic digits allowed)
const IsArabicChars().isValid('hello');     // → false

const IsEnglishChars().isValid('Hello');       // → true
const IsEnglishChars().isValid('Hello World'); // → false  (no spaces)
const IsEnglishChars().isValid('abc123');      // → false  (letters only)

const IsNumbersOnly().isValid('12345'); // → true
const IsNumbersOnly().isValid('12a');   // → false

const IsLtrLanguage().isValid('en'); // → true
const IsLtrLanguage().isValid('ar'); // → false

const IsRTLLanguage().isValid('ar'); // → true
const IsRTLLanguage().isValid('en'); // → false
```

### Colors

```dart
const IsHexColor().isValid('#FFF');      // → true   (3 digits)
const IsHexColor().isValid('A1B2C3');    // → true   (6 digits, '#' optional)
const IsHexColor().isValid('#FF0000FF'); // → true   (8 digits, with alpha)
const IsHexColor().isValid('red');       // → false
```

### Magic — `IsOptional`

`IsOptional` only makes sense inside a validator: an empty value skips the rest
and passes, but a non-empty value still has to satisfy them.

```dart
final validate = xValidator([
  const IsOptional(),
  const IsEmail(),
]);

validate('');       // → null  (empty is allowed)
validate('a@b.co'); // → null  (valid email)
validate('x');      // → IsEmail's message  (non-empty must be valid)
```

## 🛠 Usage guide

### Composing rules

Rules run top-to-bottom and the first failure is returned, so order them from
general to specific:

```dart
final validate = xValidator([
  const IsRequired(),   // checked first
  const MinLength(8),
  const MaxLength(32),
]);

validate('');        // → IsRequired's message
validate('abc');     // → MinLength's message
validate('hunter2!'); // → null (valid)
```

### Real-world recipes

Ready-to-paste validators for the fields you actually build. Each returns the
first failing rule's message, or `null` when the value passes — exactly what
`TextFormField.validator` expects.

**Password** — required, length-bounded, must contain a special character:

```dart
final password = xValidator([
  const IsRequired('Password is required'),
  const MinLength(8, 'At least 8 characters'),
  const MaxLength(64, 'At most 64 characters'),
  const ContainsAny(['!', '@', '#', '%'], error: 'Add a special character'),
]);

password('');         // → 'Password is required'
password('abc');      // → 'At least 8 characters'
password('abcdefgh'); // → 'Add a special character'
password('abcdefg!'); // → null (valid)
```

**Email** — required and well-formed:

```dart
final email = xValidator([
  const IsRequired('Email is required'),
  const IsEmail('Enter a valid email'),
]);

email('');             // → 'Email is required'
email('not-an-email'); // → 'Enter a valid email'
email('jane@acme.io'); // → null (valid)
```

**Phone** — required Egyptian mobile number:

```dart
final phone = xValidator([
  const IsRequired('Phone is required'),
  const IsEgyptianPhone('Enter a valid Egyptian number'),
]);

phone('0100');        // → 'Enter a valid Egyptian number'
phone('01012345678'); // → null (valid)
```

**Optional age** — blank is allowed, but if filled it must be a whole number in
range. Put `IsOptional` first so an empty value skips the rest and passes:

```dart
final age = xValidator([
  const IsOptional(),
  const IsNumber('Digits only'),
  const MinValue(18, 'Must be 18 or older'),
  const MaxValue(120, 'Enter a real age'),
]);

age('');   // → null (optional — blank is fine)
age('1x'); // → 'Digits only'
age('16'); // → 'Must be 18 or older'
age('30'); // → null (valid)
```

**Optional website** — blank allowed, otherwise a valid secure URL:

```dart
final website = xValidator([
  const IsOptional(),
  const IsUrl('Enter a valid URL'),
  const IsSecureUrl('Use https://'),
]);

website('');                  // → null (optional — blank is fine)
website('not a url');         // → 'Enter a valid URL'
website('http://insecure.io'); // → 'Use https://'
website('https://acme.io');    // → null (valid)
```

### Custom error messages

Pass a message as the rule's last argument to override its default:

```dart
xValidator([
  const IsRequired('Please enter a value'),
  const MinLength(8, 'Use at least 8 characters'),
]);
```

### Reacting to failures (`onFailureCallBack`)

Useful for analytics or logging. The callback receives the input, the full rule
list, and the rule that failed:

```dart
xValidator(
  [
    const IsRequired('Field cannot be empty'),
    const MinLength(3, 'At least 3 characters'),
    const MaxLength(20, 'At most 20 characters'),
  ],
  onFailureCallBack: (input, rules, failedRule) {
    debugPrint('Validation failed for "$input" on ${failedRule.runtimeType}');
  },
);
```

### Optional fields

Add `IsOptional` to let an empty field pass while still validating non-empty
input. Here an empty value is accepted, but anything typed must be a valid email:

```dart
xValidator([
  const IsOptional(),
  const IsEmail(),
]);
```

### Writing a custom rule

Extend `TextXValidationRule`, implement `isValid`, and (optionally) override
`defaultMessage` to provide a default message:

```dart
class StartsWithCapital extends TextXValidationRule {
  const StartsWithCapital([super.error]);

  @override
  bool isValid(String input) =>
      input.isNotEmpty && input[0] == input[0].toUpperCase();

  @override
  String get defaultMessage => 'Must start with a capital letter';
}

// Use it like any built-in rule:
xValidator([const StartsWithCapital()]);
```

> Overriding `toString()` still works — the base `defaultMessage` delegates to it
> — but `defaultMessage` is the preferred hook for a rule's default message.

### Localizing error messages

Register a translator per rule type with `XValidatorsLocalization.on<T>()`.
When that rule fails (and no inline `error` was given), your function supplies
the message:

```dart
XValidatorsLocalization.on<IsRequired>((rule) => 'هذا الحقل مطلوب');
XValidatorsLocalization.on<IsEmail>((rule) => 'البريد الإلكتروني غير صالح');

final validate = xValidator([const IsRequired()]);
validate(''); // → 'هذا الحقل مطلوب'
```

Resolution order for a failing rule is: **inline `error`** → **registered
translator** → **`rule.defaultMessage`**.

### Standalone helper functions

Each rule also ships a top-level function for one-off checks outside of a form,
mirroring the rule's logic:

```dart
isNotEmpty('hello');     // true
isEmpty('   ');          // true
minLength('abc', 3);     // true
EmailXValidator.validate('test@example.com'); // true
```

## ℹ️ Good to know

- A `null` value passed to the validator is treated as an empty string `''`, so
  `IsRequired` (and every other rule) sees `''` and a required field correctly
  fails on `null`. Add an `IsOptional` rule if you want an empty/`null` value to
  skip the remaining rules and pass. (Before 2.0.0, `null` short-circuited the
  whole validator to "valid" — see [Migrating to 2.0.0](#migrating-to-200).)

## Migrating to 2.0.0

2.0.0 is a behavior-only major release: the public API shape is unchanged (same
rules, same `xValidator` signature), but several rules were tightened to do what
their names promise. Most apps need no code changes — the table below lists every
behavior change and how to restore the old behavior where it's recoverable.

| Area | Before (1.x) | After (2.0.0) | How to adapt |
|------|--------------|---------------|--------------|
| `null` input | Short-circuited the whole validator to **valid** | Treated as `''`, so `IsRequired` **rejects** it | Add `IsOptional` to let empty/`null` pass |
| `IsNumber` | Accepted decimals, hex, scientific (`3.14`, `1e3`, `0x1A`) | **Integers only** | Use the new `IsDecimal` for fractional values |
| `IsArabicChars` | `\p{N}` token matched the literal chars `p{N}` and **no** digits | Accepts Arabic-Indic digits `٠-٩` only | — (this was a bug; Latin `123` was never really allowed) |
| `IsNumbersOnly` | Passed if the input *contained* a digit (`'abc1'`, `'12 34'`) | Passes only when the input **is all digits** | Use `Contains`/`RegExpRule` for "contains a digit" |
| `IsFacebookUrl` / `IsInstagramUrl` / `IsYoutubeUrl` | Unanchored — `facebook.com.evil.com` passed | Fully anchored — domain-suffix spoofing is rejected | — (intended hardening) |
| `IsUrl` | Rejected hyphens, deep subdomains, long TLDs | Accepts `my-site.co.uk`, `a.b.example.com`, `example.museum` | — (relaxation only) |
| `IsIpAddress` | Tolerated leading zeros and whitespace (`192.168.001.001`, `' 1.2.3.4'`) | Strict dotted-quad | Trim/normalize before validating if needed |
| `ContainsAny` | `error` was positional; `caseSensitive` was a dead no-op | `error` is named; `caseSensitive` works | See snippet below |
| `IsArabicNum` / `IsHindiNum` | Both used key `validation.must_be_num` | `validation.must_be_arabic_num` / `validation.must_be_hindi_num` | Re-key your translators (inline `error:` is unaffected) |
| `isInstgramUrlValid` | Typo'd free function | Renamed to `isInstagramUrlValid` | Old name still works as a `@Deprecated` alias |

### Decimals: `IsNumber` → `IsDecimal`

```dart
// 1.x — accepted "3.14"
xValidator([const IsNumber()]);

// 2.0.0 — integers only; use IsDecimal for fractional input
xValidator([const IsDecimal()]);
```

### `ContainsAny`: `error` is now named, `caseSensitive` now works

```dart
// 1.x
const ContainsAny(['a', 'b'], 'Pick one');          // positional error
final r = ContainsAny(['a'])..caseSensitive = true; // dead no-op field

// 2.0.0
const ContainsAny(['a', 'b'], error: 'Pick one');   // named error
const ContainsAny(['a'], caseSensitive: true);      // actually case-sensitive
```

> If you imported individual rule files directly, note two internal renames:
> `text/is_not_empty.dart` → `text/is_required.dart` and
> `urls/is_instgram_url.dart` → `urls/is_instagram_url.dart`. Importing the
> package barrel (`package:x_validators/x_validators.dart`) needs no change.

## 📄 License

See [**LICENSE**](https://github.com/Eng-MahmoudBasuony/x_validators/blob/main/LICENSE).

## 👨🏻‍💻 Author

<table>
  <tr>
    <td width="120">
      <a href="https://github.com/Eng-MahmoudBasuony">
        <img src="https://raw.githubusercontent.com/Eng-MahmoudBasuony/x_validators/main/author.png" width="110" alt="Mahmoud Basuony" />
      </a>
    </td>
    <td>
      <strong><a href="https://github.com/Eng-MahmoudBasuony">Mahmoud Basuony</a></strong><br>
      Software Engineer<br><br>
      If x_validators saved you some boilerplate, a ⭐ on the
      <a href="https://github.com/Eng-MahmoudBasuony/x_validators">repo</a>
      is appreciated.
    </td>
  </tr>
</table>
