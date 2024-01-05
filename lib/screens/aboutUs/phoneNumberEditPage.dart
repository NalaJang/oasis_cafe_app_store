import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';

import '../../config/palette.dart';

class PhoneNumberEditPage extends StatefulWidget {
  const PhoneNumberEditPage({Key? key}) : super(key: key);

  static const String routeName = '/phoneNumberEditPage';

  @override
  State<PhoneNumberEditPage> createState() => _PhoneNumberEditPageState();
}

class _PhoneNumberEditPageState extends State<PhoneNumberEditPage> {

  var number1 = TextEditingController();
  var number2 = TextEditingController();
  var number3 = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    number1.dispose();
    number2.dispose();
    number3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor1,
        title: const Text('전화번호 수정'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            _numberTextFormField(true, 3, number1),
            Gaps.gapW10,
            _numberTextFormField(false, 4, number2),
            Gaps.gapW10,
            _numberTextFormField(false, 4, number3),
          ],
        ),
      ),
    );
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
          decoration: const InputDecoration(
            counterText: '',
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(10)
          ),
        ),
      ),
    );
  }
}
