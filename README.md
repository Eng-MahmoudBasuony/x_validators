 # ☕ X Validators 
![Pub](https://img.shields.io/pub/v/x_validators)
![GitHub License](https://img.shields.io/github/license/Eng-MahmoudBasuony/x_validators)

Simplest form validation for flutter form widgets.
* Zero dependency
* Extensible
* Well tested
* Open source
    
 ## 🚀 Installation 
 
Add the following to your `pubspec.yaml` file

```yaml
dependencies:
   x_validators: ^1.0.2
```

Don't forget to `flutter pub get`.

## Api Overview

| Rules for `Text` | Description |
| -------- | ------- |
|`IsRequired()`| Ensures that the trimmed input is not empty. |
|`Contains()`| Verifies if the input string contains the provided value. |
|`EndsWith()`| Ensures that the input string ends with a specific value. |
|`IsEmpty()`| Ensures that the trimmed input is empty. |
|`Match()`| Verifies if the input matches the specified string. |
|`MaxLength()`| Ensures that the length is less than or equal to the specified maximum. |
|`MinLength()`| Ensures that the length is greater than or equal to the specified minimum. |
|`NotContains()`| Verifies if the input string does not contain the provided value. |
|`StartsWith()`| Ensures that the input string starts with a specific pattern. |

| Rules for `NUMBERS` | Description |
| -------- | ------- |
|`IsArabicNum()`| Verifies if the input is a valid Arabic integer. |
|`IsHindiNum()`| Verifies if the input is a valid Hindi integer. |
|`IsNumber()`| Verifies if the input is a valid integer. |
|`MaxValue()`|  Verifies if the numeric value is less than or equal to the specified maximum. |
|`MinValue()`| Verifies if the numeric value is greater than or equal to the specified minimum. |

| Rules for `URLS` | Description |
| -------- | ------- |
|`IsFacebookUrl()`| Verifies if the input is a valid Facebook URL. |
|`IsInstagramUrl()`| Verifies if the input is a valid Instagram URL. |
|`IsSecureUrl()`| Verifies if the input is a secure URL (starts with `'https://'`). |
|`IsUrl()`|  Verifies if the input is a valid URL. |
|`IsYoutubeUrl()`| Verifies if the input is a valid YouTube URL. |

| Rules for `Phone` | Description |
| -------- | ------- |
|`IsEgyptianPhone()`| Verifies if the input is a valid Egyptian phone number. |
|`ISKsaPhone()`| Verifies if the input is a valid Saudi Arabian phone number. |


## License

Please see [**LICENSE**](https://github.com/Eng-MahmoudBasuony/x_validators/blob/main/LICENSE).


## 👨🏻‍💻 Authors
- [@Eng-MahmoudBasuony](https://Eng-MahmoudBasuony)
