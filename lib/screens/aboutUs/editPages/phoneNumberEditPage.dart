import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';
import 'package:oasis_cafe_app_store/provider/phoneNumberController.dart';

import '../../../config/palette.dart';

class PhoneNumberEditPage extends StatefulWidget {
  const PhoneNumberEditPage({Key? key}) : super(key: key);

  static const String routeName = '/phoneNumberEditPage';

  @override
  State<PhoneNumberEditPage> createState() => _PhoneNumberEditPageState();
}

class _PhoneNumberEditPageState extends State<PhoneNumberEditPage> {

  bool showSpinner = false;
  final formKey = GlobalKey<FormState>();
  var number1Controller = TextEditingController();
  var number2Controller = TextEditingController();
  var number3Controller = TextEditingController();


  bool _tryValidation() {
    final isValid = formKey.currentState!.validate();

    if( isValid ) {
      formKey.currentState!.save();
    }
    return isValid;
  }

  @override
  void initState() {
    super.initState();

    var phoneNumberController = Get.find<PhoneNumberController>();
    number1Controller.text = phoneNumberController.number1.value;
    number2Controller.text = phoneNumberController.number2.value;
    number3Controller.text = phoneNumberController.number3.value;

  }

  @override
  void dispose() {
    super.dispose();

    number1Controller.dispose();
    number2Controller.dispose();
    number3Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor1,
        title: const Text('전화번호 수정'),
      ),

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _numberTextFormField(true, 3, number1Controller),
                    Gaps.gapW10,
                    _numberTextFormField(false, 4, number2Controller),
                    Gaps.gapW10,
                    _numberTextFormField(false, 4, number3Controller),
                  ],
                ),
                Gaps.spacer,

                // 수정 버튼
                _updateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }


  // 수정 버튼
  Widget _updateButton() {
    return ElevatedButton(
      onPressed: () async {

        var isValid = _tryValidation();
        if( isValid ) {
          // 전화번호 저장
          await _pressedUpdateButton();
        }
      },

      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Palette.buttonColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        side: const BorderSide(
          color: Palette.buttonColor1,
        )
      ),

      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        child: const Text(
          '수정하기',
          textAlign: TextAlign.center,
        ),
      )
    );
  }

  // 전화번호 저장
  _pressedUpdateButton() async {
    var phoneNumberController = Get.find<PhoneNumberController>();

    try {
      setState(() {
        showSpinner = true;
      });
      var isUpdated = await phoneNumberController.updatePhoneNumber(number1Controller.text, number2Controller.text, number3Controller.text);

      if( isUpdated ) {
        // Fetch the updated phone number after the update
        await phoneNumberController.getPhoneNumber();
        _showSnackBar('전화번호가 수정되었습니다.');
      }

    } catch(e) {
      print(e);
      _showSnackBar(e.toString());
    } finally {
      setState(() {
        showSpinner = false;
      });
    }
  }


  Widget _numberTextFormField(bool autoFocus, int maxLength, TextEditingController controller) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey)
        ),

        child: TextFormField(
          autofocus: autoFocus,
          maxLength: maxLength,
          controller: controller,
          keyboardType: TextInputType.number,
          validator: (value) {
            if( value!.trim().isEmpty ) {
              return value = '번호를 입력해 주세요.';
            }
            return null;
          },
          decoration: const InputDecoration(
            counterText: '',
            hintText: '000',
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(10)
          ),
        ),
      ),
    );
  }

  _showSnackBar(String content) {
    setState(() {
      showSpinner = false;
    });

    Get.snackbar(
      '수정',
      content,
      snackPosition: SnackPosition.TOP
    );
  }
}
