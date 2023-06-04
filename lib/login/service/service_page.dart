// ignore: unused_import
import 'package:catering/home/view/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:plavon/home/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  static final _client = http.Client();

  static var _loginUrl =
      Uri.parse('https://katering.eastbluetechnology.com/api/auth/login');
  static login(username, password, context) async {
    // bool isLoading = false;
    http.Response response = await _client
        .post(_loginUrl, body: {"username": username, "password": password});
    // print(response.body);
    if (response.statusCode == 200) {
      var Users = jsonDecode(response.body);
      print(Users);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("username", username);
      await pref.setString("id_user", Users['data']['id'].toString());
      await pref.setString("token", Users['token'].toString());
      await pref.setBool("is_login", true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    }
  }
}
