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
- [Usage guide](#-usage-guide)
  - [Composing rules](#composing-rules)
  - [Custom error messages](#custom-error-messages)
  - [Reacting to failures](#reacting-to-failures-onfailurecallback)
  - [Optional fields](#optional-fields)
  - [Writing a custom rule](#writing-a-custom-rule)
  - [Localizing error messages](#localizing-error-messages)
  - [Standalone helper functions](#standalone-helper-functions)
- [Good to know](#-good-to-know)
- [Contributing](#-contributing)
- [License](#-license)

## 🚀 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  x_validators: ^1.1.0
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

All rules accept an optional positional `error` message as their **last**
argument (e.g. `IsRequired('This field is required')`). When omitted, the rule's
default message is used (see [Localizing error messages](#localizing-error-messages)).

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
| `IsNumber([error])` | Input is a number. |
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
| `ContainsAny(values, [error])` | Input contains at least one item from the list. |
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
| `IsArabicChars([error])` | Input consists of Arabic characters. |
| `IsEnglishChars([error])` | Input consists of English (ASCII) characters. |
| `IsNumbersOnly([error])` | Input contains digits. |
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
`toString()` to provide a default message:

```dart
class StartsWithCapital extends TextXValidationRule {
  const StartsWithCapital([super.error]);

  @override
  bool isValid(String input) =>
      input.isNotEmpty && input[0] == input[0].toUpperCase();

  @override
  String toString() => 'Must start with a capital letter';
}

// Use it like any built-in rule:
xValidator([const StartsWithCapital()]);
```

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
translator** → **`rule.toString()`**.

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

- A `null` value passed to the validator is currently treated as valid (it
  short-circuits to `null`). In practice Flutter's `TextFormField` passes an
  empty string `''` rather than `null`, which `IsRequired` rejects as expected.
  Treating `null` as empty is planned for the next major release.

## 🤝 Contributing

Issues and pull requests are welcome. Please run `dart analyze` and `dart test`
before opening a PR.

## 📄 License

See [**LICENSE**](https://github.com/Eng-MahmoudBasuony/x_validators/blob/main/LICENSE).

## 👨🏻‍💻 Authors

- [@Eng-MahmoudBasuony](https://github.com/Eng-MahmoudBasuony)
