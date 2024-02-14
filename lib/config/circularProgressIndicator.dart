import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';


class CircularProgressBar {
  static const Widget circularProgressBar =
  Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Palette.buttonColor1),
    ),
  );
}