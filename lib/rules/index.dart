/// A library that provides a collection of text validation rules for various purposes.
///
/// This library exports a wide range of validators, including color validation, date validation,
/// IT-related validation, language validation, list-related validation, magic validation,
/// number validation, phone number validation, text validation, and URL validation.
library x_validators;

// * Exporting color-related validators
export 'colors/is_hex_color.dart';
// * Exporting date-related validators
export 'dates/date_after.dart';
export 'dates/is_date.dart';
export 'dates/is_date_mills.dart';
// * Exporting IT-related validators
export 'it/is_boolean.dart';
export 'it/is_email.dart';
export 'it/is_port.dart';
export 'it/regx.dart';
// * Exporting language-related validators
export 'languages/is_ltr_language.dart';
export 'languages/is_rtl_language.dart';
// * Exporting list-related validators
export 'lists/contains_any.dart';
export 'lists/is_in.dart';
export 'lists/is_not_in.dart';
export 'lists/not_contains_any.dart';
// * Exporting magic-related validators
export 'magic/is_optional.dart';
export 'numbers/is_arabic_num.dart';
// * Exporting number-related validators
export 'numbers/is_hindi_num.dart';
export 'numbers/is_number.dart';
export 'numbers/max_value.dart';
export 'numbers/min_value.dart';
// * Exporting phone-related validators
export 'phone/is_egy_number.dart';
export 'phone/is_ksa_number.dart';
// * Exporting text-related validators
export 'text/contains.dart';
export 'text/ends_with.dart';
export 'text/is_empty.dart';
export 'text/is_not_empty.dart';
export 'text/match.dart';
export 'text/max_length.dart';
export 'text/min_length.dart';
export 'text/not_contains.dart';
export 'text/starts_with.dart';
// * Exporting URL-related validators
export 'urls/is_facebook_url.dart';
export 'urls/is_instgram_url.dart';
export 'urls/is_url.dart';
export 'urls/is_youtube_url.dart';
