import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:x_validators/x_validators.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      title: '☕ x validators ☕',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData.light(),
    ),
  );
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚀 ☕ x validators ☕ 🚀'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () async {
          final isFormValid = _formKey.currentState!.validate();
          if (isFormValid) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('the form is valid ✔'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('not valid form ❌'),
              ),
            );
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // TextFormField(
              //   decoration: const InputDecoration(labelText: 'IsRequired'),
              //   validator: xValidator([
              //     IsRequired(),
              //   ]),
              // ),
              // TextFormField(
              //   decoration: const InputDecoration(labelText: 'IsOptional'),
              //   validator: xValidator([
              //     // if the textField contains value the rest of the validators
              //     // will run else it will pass alidation with checking them
              //     IsOptional(),
              //
              //     /// the input value must be a
              //     /// valid (`well formatted`) email address
              //     const IsEmail(),
              //   ]),
              // ),
              // TextFormField(
              //   decoration:
              //       const InputDecoration(labelText: 'IsRequired AND IsEmail'),
              //   validator: xValidator([
              //     IsRequired(),
              //
              //     /// the input value must be a valid (`well formatted`)
              //     ///  email address
              //     const IsEmail(),
              //   ]),
              // ),
              // TextFormField(
              //   decoration:
              //       const InputDecoration(labelText: 'MinLenght AND IsEmail'),
              //   validator: xValidator([
              //     IsRequired(),
              //
              //     /// the input min length must be >= 5
              //     MinLength(10),
              //
              //     /// the input max length must be <= 10
              //     MaxLength(15),
              //   ]),
              // ),
              // TextFormField(
              //   decoration:
              //       const InputDecoration(labelText: 'IsIn AND IsNotIn'),
              //   validator: xValidator(
              //     [
              //       IsRequired(),
              //       IsIn(['white', 'black', 'gray']),
              //       IsNotIn(['red', 'blue', 'orange']),
              //     ],
              //   ),
              // ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'IsRequiredddd'),
                validator: xValidator([
                  // Ensures that the input is not empty with a custom error message.
                  IsRequired("Field cannot be empty"),

                  // Ensures that the input has a minimum length of 3 characters.
                  MinLength(3, "Field must be at least 3 characters"),

                  // Ensures that the input does not exceed a maximum length of 20 characters.
                  MaxLength(20, "Field cannot exceed 20 characters"),
                ], onFailureCallBack: (String? fieldInput,
                    List<TextXValidationRule> rules,
                    TextXValidationRule failedRule) {
                  // Logs information about the failed validation for further analysis.
                  log("###### Validation failed for input #### : $fieldInput");
                  log("::::::: error  ${failedRule.error} ::::::::");

                  for (var element in rules) {
                    log("::::::: Class Name ${element.runtimeType.toString()} ::::::::");
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
