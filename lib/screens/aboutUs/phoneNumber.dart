import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title()
      ],
    );
  }

  Widget _title() {
    return Row(
      children: const [
        Icon(Icons.phone),

        Text(
          ' 전화번호',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
