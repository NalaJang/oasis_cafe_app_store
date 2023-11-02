import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/provider/aboutUsProvider.dart';
import 'package:oasis_cafe_app_store/provider/openingHoursProvider.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:oasis_cafe_app_store/provider/userStateProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
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
        ChangeNotifierProvider(create: (context) => AboutUsProvider()),
        ChangeNotifierProvider(create: (context) => OpeningHoursProvider()),
      ],

      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}

