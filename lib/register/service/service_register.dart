import 'dart:convert';
import 'package:catering/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';

class HttpService {
  static var _registerUrl =
      Uri.parse('https://travel.dlhcode.com/api/register');
  static register(email, password, nama, noHp, context) async {
    http.Response response = await http.post(_registerUrl, body: {
      "email": email,
      "password": password,
      "nama": nama,
      "no_hp": noHp,
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());

      if (json == 'username already exist') {
        await EasyLoading.showError(json);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}
