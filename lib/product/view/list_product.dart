import 'package:catering/home/menu_page.dart';
import 'package:catering/product/view/product_detail.dart';
import 'package:flutter/material.dart';
// ignore: duplicate_import
import 'package:catering/home/menu_page.dart';
// ignore: unused_import
import 'package:catering/home/view/home.dart';
// import 'package:catering/product/view/product_detail.dart';
// import 'package:plavon/product/service/service_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List _get = [];
  Future barang() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      // print(token);
      var url = Uri.parse('https://katering.eastbluetechnology.com/api/paket');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      // print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(data);
        setState(() {
          _get = data;
          // print(_get);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    barang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          onRefresh: barang,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _get.length,
              itemBuilder: (_, i) => Card(
                    child: Container(
                      height: 290,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (
                                    context,
                                  ) =>
                                      DetailProduct(
                                    id: _get[i]['id'].toString(),
                                    nama_paket:
                                        _get[i]['nama_paket'].toString(),
                                    harga: _get[i]['harga'].toString(),
                                    gambar: _get[i]['gambar'].toString(),
                                    keterangan:
                                        _get[i]['keterangan'].toString(),
                                    stok:
                                        _get[i]['stok'].toString(),
                                    created_at:
                                        _get[i]['created_at'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    '${_get[i]['gambar'].toString()}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  '${_get[i]['nama_paket'].toString()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Harga: ${_get[i]['harga']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    
                                  ],
                                  
                                ),
                                Text(
                                      'Stok: ${_get[i]['stok']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
      drawer: MenuPage(),
    );
  }
}
// Container(
//               margin: const EdgeInsets.all(5),
//               color: Colors.grey,
//               child: Center(child: Text('${_get[i]['nama_barang']}')),
//             ),