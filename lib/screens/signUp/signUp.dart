import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/provider/userStateProvider.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';
import 'package:provider/provider.dart';

import '../login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var formKey = GlobalKey<FormState>();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userNameController = TextEditingController();
  var userMobileNumberController = TextEditingController();

  bool showSpinner = false;


  bool _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }


  InputDecoration _getTextFormDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();

    userEmailController.dispose();
    userPasswordController.dispose();
    userNameController.dispose();
    userMobileNumberController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.signUp),
        backgroundColor: Palette.buttonColor1,
      ),

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // 이메일
                  TextFormField(
                    controller: userEmailController,
                    validator: (value) =>
                    value == '' ? Strings.emailValidation : null,

                    decoration: _getTextFormDecoration(Strings.email)
                  ),

                  Gaps.gapH30,

                  // 비밀번호
                  TextFormField(
                    controller: userPasswordController,
                    validator: (value) {
                      if( value == '' || value!.length < 6 ) {
                        return Strings.passwordValidation;
                      } else {
                        return null;
                      }
                    },

                    decoration: _getTextFormDecoration(Strings.password),
                  ),

                  Gaps.gapH30,

                  // 비밀번호 확인
                  TextFormField(
                    validator: (value) {
                      if( value == '' || value != userPasswordController.text ) {
                        return Strings.confirmPasswordValidation;
                      } else {
                        return null;
                      }
                    },

                    decoration: _getTextFormDecoration(Strings.confirmPassword),
                  ),

                  Gaps.gapH30,

                  // 이름
                  TextFormField(
                    controller: userNameController,
                    validator: (value) =>
                    value == '' ? Strings.nameValidation : null,

                    decoration: _getTextFormDecoration(Strings.name)

                  ),

                  Gaps.gapH30,

                  // 휴대폰 번호
                  TextFormField(
                    controller: userMobileNumberController,
                    validator: (value) =>
                    value == '' ? Strings.mobileNumberValidation : null,

                    decoration: _getTextFormDecoration(Strings.mobileNumber)

                  ),

                  Gaps.gapH30,

                  // 회원 가입 버튼
                  signUpButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 회원 가입 버튼
  GestureDetector signUpButton() {
    return GestureDetector(
      onTap: () async {

        // 사용자 입력 값 유효성 검사
        if( _tryValidation() ) {

          try {
            setState(() {
              showSpinner = true;
            });

            var isSignUp = Provider.of<UserStateProvider>(context, listen: false)
                .signUp(
                userEmailController.text,
                userPasswordController.text,
                userNameController.text,
                userMobileNumberController.text
            );

            if( await isSignUp ) {
              setState(() {
                showSpinner = false;
              });

              if( mounted ) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '회원가입이 완료되었습니다.',
                      ),
                    )
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login())
                );
              }
            }

          } catch (e) {
            print(e);
            if( mounted ) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          e.toString()
                      )
                  )
              );

              setState(() {
                showSpinner = false;
              });
            }
          }
        }
      },

      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Palette.buttonColor1,
            borderRadius: BorderRadius.circular(12.0)
        ),

        child: const Center(
          child: Text(
              Strings.signUp,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )
          ),
        ),
      ),
    );

  }
}
