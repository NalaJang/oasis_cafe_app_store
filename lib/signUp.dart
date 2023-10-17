import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.signUp),
      ),
    );
  }
}
