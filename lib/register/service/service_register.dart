import 'dart:convert';
import 'package:catering/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';

class HttpService {
  static var _registerUrl =
      Uri.parse('https://katering.eastbluetechnology.com/api/auth/register');
  static register(username, email, fullName, password, noHp, alamat,
      jenis_kelamin, context) async {
    http.Response response = await http.post(_registerUrl, body: {
      "username": username.toString(),
      "email": email.toString(),
      "fullName": fullName.toString(),
      "password": password.toString(),
      "noHp": noHp.toString(),
      "alamat": alamat.toString(),
      "jenisKelamin": jenis_kelamin.toString(),
      "roleId": '2',
    });
    print(response.body);
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
