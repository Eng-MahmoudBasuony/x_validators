import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:x_validators/x_validators.dart';

void main() {
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
  HomePage({super.key});

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
        onPressed: () {
          final isFormValid = _formKey.currentState!.validate();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  isFormValid ? 'the form is valid ✔' : 'not valid form ❌'),
            ),
          );
        },
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            // A simple required field.
            TextFormField(
              decoration: const InputDecoration(labelText: 'IsRequired'),
              validator: xValidator([
                const IsRequired(),
              ]),
            ),

            // Optional: when empty the field passes; when filled it must be a
            // well-formatted email address.
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'IsOptional + IsEmail'),
              validator: xValidator([
                const IsOptional(),
                const IsEmail(),
              ]),
            ),

            // Required AND a valid email.
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'IsRequired + IsEmail'),
              validator: xValidator([
                const IsRequired(),
                const IsEmail(),
              ]),
            ),

            // Length bounds (rules run in order, first failure wins).
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'MinLength + MaxLength'),
              validator: xValidator([
                const IsRequired(),
                const MinLength(10),
                const MaxLength(15),
              ]),
            ),

            // Allow / disallow lists.
            TextFormField(
              decoration: const InputDecoration(labelText: 'IsIn + IsNotIn'),
              validator: xValidator([
                const IsRequired(),
                const IsIn(['white', 'black', 'gray']),
                const IsNotIn(['red', 'blue', 'orange']),
              ]),
            ),

            // Newly exported rules.
            TextFormField(
              decoration: const InputDecoration(labelText: 'IsSecureUrl'),
              validator: xValidator([
                const IsOptional(),
                const IsSecureUrl(),
              ]),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'IsArabicChars'),
              validator: xValidator([
                const IsOptional(),
                const IsArabicChars(),
              ]),
            ),

            // Custom error messages + an onFailureCallBack for analytics/logging.
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Custom errors + callback'),
              validator: xValidator(
                [
                  const IsRequired('Field cannot be empty'),
                  const MinLength(3, 'Field must be at least 3 characters'),
                  const MaxLength(20, 'Field cannot exceed 20 characters'),
                ],
                onFailureCallBack: (input, rules, failedRule) {
                  log('Validation failed for input: $input');
                  log('Failed rule: ${failedRule.runtimeType} -> ${failedRule.error}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
