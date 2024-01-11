/// A library that provides a collection of text validation utilities.
///
/// This library exports various modules for validating text, including email validation,
/// predefined validation rules, an abstract class for creating custom rules,
/// and a general-purpose `xValidator` function for performing validations.
/// Additionally, it exports language utilities from the core package.
library x_validators;

// Importing the email validator from the x_validators package
export 'package:x_validators/email_validator.dart';
// Exporting rules from the rules directory
export 'package:x_validators/rules/index.dart';
// Exporting the abstract class for implementing custom rules
export 'package:x_validators/text_rule_class.dart';
// Exporting the xValidator function for easy access
export 'package:x_validators/validator.dart';

// Exporting language utilities from the core/utils directory
export '../../core/utils/language_utils.dart';
