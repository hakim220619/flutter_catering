import 'package:catering/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LoginApp",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
