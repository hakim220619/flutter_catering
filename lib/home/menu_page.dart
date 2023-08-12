import 'package:catering/home/view/home.dart';
import 'package:catering/profile/view/profile.dart';
import 'package:catering/transaksi/view/transaksi_page.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
// ignore: duplicate_import
import 'package:catering/home/view/home.dart';
// ignore: unused_import
import 'package:catering/login/view/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  String _email = "";
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
    });
  }

  Widget build(BuildContext context) {
    return SizedBox(
      //membuat menu drawer
      child: Drawer(
        //membuat list,
        //list digunakan untuk melakukan scrolling jika datanya terlalu panjang
        child: ListView(
          padding: EdgeInsets.zero,
          //di dalam listview ini terdapat beberapa widget drawable
          children: [
            UserAccountsDrawerHeader(
              //membuat gambar profil
              
              //membuat nama akun
              accountName: Text(""),
              //membuat nama email
              accountEmail: Text(''),
              //memberikan background
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/gambar1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //membuat list menu
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Menu"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (
                      context,
                    ) =>
                            HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text("Transaksi"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (
                      context,
                    ) =>
                            TransaksiPage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.emoji_emotions),
              title: Text("Profil"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (
                      context,
                    ) =>
                            ProfilePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

//widget ini adalah isi dari sidebar atau drawer