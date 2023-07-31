import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
 List _get = [];
 String full_name = '';
 String alamat = '';
 String jenis_kelamin= '';
 String no_hp= '';
class _ProfilePageState extends State<ProfilePage> {
 
  Future profile() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      var url = Uri.parse('https://katering.eastbluetechnology.com/api/user');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + token.toString(),
      });
      // print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
           full_name = data['full_name'];
           alamat = data['alamat'];
           jenis_kelamin = data['jenis_kelamin'];
           no_hp = data['no_hp'];
          // print(data);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    profile();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: Text("Profile"),), body: Center(
            child: Profile(
              imageUrl: "https://images.unsplash.com/photo-1598618356794-eb1720430eb4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
              name: full_name,
              website: "",
              designation: alamat,
              email: "",
              phone_number: no_hp,
            ),
          ) ),
      
    );
  }
}