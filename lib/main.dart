import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oasis_cafe_app_store/provider/openingHoursProvider.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:oasis_cafe_app_store/provider/phoneNumberController.dart';
import 'package:oasis_cafe_app_store/provider/userStateProvider.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/editPages/openingHoursEditPage.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/editPages/phoneNumberEditPage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  // Registering PhoneNumberProvider with Get
  Get.put(PhoneNumberController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserStateProvider()),
        ChangeNotifierProvider(create: (context) => OrderStateProvider()),
        ChangeNotifierProvider(create: (context) => OpeningHoursProvider()),
        // ChangeNotifierProvider(create: (context) => PhoneNumberProvider()),
      ],

      // getX 를 사용하기 위해 MaterialApp -> GetMaterialApp 로 변경
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Login.routeName,
        routes: routes,
        // home: Login(),
      ),
    );
  }
}

final routes = {
  Login.routeName : (context) => const Login(),
  OpeningHoursEditPage.routeName : (context) => const OpeningHoursEditPage(),
  PhoneNumberEditPage.routeName : (context) => const PhoneNumberEditPage(),
};

