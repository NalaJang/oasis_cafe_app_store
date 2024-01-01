import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  bool showSpinner = false;
  bool isChecked = false;
  var formKey = GlobalKey<FormState>();
  var storage = const FlutterSecureStorage();
  dynamic userInfo = '';

  void _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid) {
      formKey.currentState!.save();
    }
  }


  @override
  void initState() {
    super.initState();

    // 자동 로그인 확인
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userInfo = await storage.read(key: 'STATUS_LOGIN');

      if( userInfo != null ) {
        Provider.of<UserStateProvider>((context), listen: false).getUserInfo(userInfo);

        Navigator.push(
          (context),
          MaterialPageRoute(builder: (context) => const Home())
        );
      }
    });
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

                const Banner(),

                // 이메일, 비밀번호 텍스트 필드
                const EmailPasswordField(),

                // 로그인 상태 유지
                _autoLoginCheckBox(),
                const SizedBox(height: 30,),

                // 로그인 버튼
                _loginButton(),

                const SizedBox(height: 20,),

                // 비밀번호 찾기, 회원가입 메뉴
                const BottomMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _autoLoginCheckBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            }
          ),

          const Text('로그인 상태 유지'),
        ],
      ),
    );
  }

  // 로그인 버튼
  Widget _loginButton() {
    var userProvider = Provider.of<UserStateProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () async {

          _tryValidation();

          try {
            setState(() {
              showSpinner = true;
            });

            var email = userProvider.userEmail;
            var password = userProvider.userPassword;
            var isLogged = userProvider.signIn(email, password);

            if( await isLogged ) {
              setState(() {
                showSpinner = false;
              });

              // 자동 로그인 체크 박스 체크를 했다면, storage 에 사용자 정보 저장
              if( isChecked ) {
                storage.write(key: 'STATUS_LOGIN', value: userProvider.userUid);
              }

              Navigator.push(
                (context),
                MaterialPageRoute(builder: (context) => const Home())
              );
            }

          } catch (e) {
            debugPrint(e.toString());
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
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.coffee,
          size: 80,
        ),

        SizedBox(height: 30,),

        Text(
          Strings.hello,
          style: TextStyle(
              fontSize: 20.0
          ),
        ),

        SizedBox(height: 10,),

        Text(
          Strings.welcome,
          style: TextStyle(
              fontSize: 20.0
          ),
        ),

        SizedBox(height: 50,),
      ],
    );
  }
}


class EmailPasswordField extends StatelessWidget {
  const EmailPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserStateProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextFormField(
            initialValue: userProvider.userEmail,
            onChanged: (value) => {
              userProvider.userEmail = value,
            },
            validator: (value) =>
            value == '' ? Strings.emailValidation : null,

            decoration: _getDecoration(Strings.email),
          ),
        ),

        const SizedBox(height: 20,),

        // password
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextFormField(
            initialValue: userProvider.userPassword,
            onChanged: (value) => {
              userProvider.userPassword = value,
            },
            validator: (value) {
              if( value == '' || value!.length < 6 ) {
                return Strings.passwordValidation;

              } else {
                return null;
              }
            },

            decoration: _getDecoration(Strings.password),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
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
}

// 비밀번호 찾기, 회원가입 메뉴
class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 비밀번호 찾기
        const Text(Strings.forgottenPassword),

        const Text(' | '),

        // 회원가입
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUp())
            );
          },

          child: const Text(Strings.createAnAccount),
        ),
      ],
    );
  }
}


