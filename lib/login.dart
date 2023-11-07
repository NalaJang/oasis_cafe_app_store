import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/provider/userStateProvider.dart';
import 'package:oasis_cafe_app_store/screens/home/home.dart';
import 'package:oasis_cafe_app_store/signUp.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var formKey = GlobalKey<FormState>();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();

  bool showSpinner = false;

  void _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid) {
      formKey.currentState!.save();
    }
  }

  InputDecoration _getDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue
            )
        )
    );
  }


  @override
  void dispose() {
    super.dispose();

    userEmailController.dispose();
    userPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.coffee,
                  size: 80,
                ),

                const SizedBox(height: 30,),

                const Text(
                  Strings.hello,
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),

                const SizedBox(height: 10,),

                const Text(
                  Strings.welcome,
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),

                const SizedBox(height: 50,),

                // email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: userEmailController,
                    validator: (value) =>
                    value == '' ? Strings.emailValidation : null,

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Strings.email),
                  ),
                ),

                const SizedBox(height: 20,),

                // password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: userPasswordController,
                    validator: (value) {
                      if( value == '' || value!.length < 6 ) {
                        return Strings.passwordValidation;

                      } else {
                        return null;
                      }
                    },

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Strings.password),
                  ),
                ),

                const SizedBox(height: 30,),

                // 로그인 버튼
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () async {

                      _tryValidation();

                      try {
                        setState(() {
                          showSpinner = true;
                        });

                        var isLogged = Provider
                            .of<UserStateProvider>(context, listen: false)
                            .signIn(
                            'admin3@email.com',
                            '123456'
                        );

                        if( await isLogged ) {
                          setState(() {
                            showSpinner = false;
                          });

                          Navigator.push(
                              (context),
                              MaterialPageRoute(builder: (context) => const Home())
                          );
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
                    },

                    // sign in button
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Palette.buttonColor1,
                          borderRadius: BorderRadius.circular(12)
                      ),

                      child: const Center(
                        child: Text(
                          Strings.signIn,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                        Strings.forgottenPassword
                    ),

                    const SizedBox(height: 10,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUp())
                        );
                      },

                      child: const Text(
                          Strings.createAnAccount
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
