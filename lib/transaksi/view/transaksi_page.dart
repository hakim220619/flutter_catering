import 'package:catering/pay/view/pay.dart';
import 'package:flutter/material.dart';
import 'package:catering/home/menu_page.dart';
// ignore: unused_import
import 'package:catering/home/view/home.dart';
// import 'package:catering/pay/view/pay.dart';
// ignore: unused_import
// import 'package:catering/transaksi/view/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

List _get = [];

class _TransaksiPageState extends State<TransaksiPage> {
  Future riwayatTiket() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var id_user = preferences.getString('id_user');
      var token = preferences.getString('token');
      var _riwayatTiket = Uri.parse(
          'https://katering.eastbluetechnology.com/api/get_pemesanan_by_id/${id_user.toString()}');
      http.Response response = await http.get(_riwayatTiket, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + token.toString(),
      });
      // print(id_user);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _get = data['data'];
          print(_get);
        });
        // print(_get[0]['order_id']);

        // print(data);
        for (var i = 0; i < data['data'].length; i++) {
          var orderId = data['data'][i]['order_id'];
          // print(orderId);
          String username = 'SB-Mid-server-z5T9WhivZDuXrJxC7w-civ_k';
          String password = '';
          String basicAuth =
              'Basic ' + base64Encode(utf8.encode('$username:$password'));
          http.Response responseTransaksi = await http.get(
            Uri.parse(
                "https://api.sandbox.midtrans.com/v2/" + orderId + "/status"),
            headers: <String, String>{
              'authorization': basicAuth,
              'Content-Type': 'application/json'
            },
          );
          var jsonTransaksi = jsonDecode(responseTransaksi.body.toString());
          // print(jsonTransaksi);
          if (jsonTransaksi['status_code'] == '200') {
            var updateTransaksi =
                Uri.parse('https://katering.eastbluetechnology.com/api/updateTransaksi');
            // ignore: unused_local_variable
            http.Response getOrderId =
                await http.post(updateTransaksi, headers: {
              "Accept": "application/json",
              "Authorization": "Bearer " + token.toString(),
            }, body: {
              "order_id": orderId,
            });
            // print(getOrderId.body);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future refresh() async {
    setState(() {
      riwayatTiket();
    });
  }

  void initState() {
    super.initState();
    riwayatTiket();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Transaksi"),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            itemCount: _get.length,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.all(10),
              elevation: 8,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 48, 31, 83),
                  child: Image.network(
                                    '${_get[index]['gambar'].toString()}',
                                    fit: BoxFit.fill,
                                  ),
                ),
                title: Text(
                  "" +
                      _get[index]['nama_paket'].toString(),
                  style: new TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("Jml " +
                  _get[index]['jumlah_pesan'].toString() +
                      " | "
                          "Tgl " +
                      _get[index]['created_at'].toString(),
                  maxLines: 2,
                  style: new TextStyle(fontSize: 14.0),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(_get[index]['status_pemesanan'].toString()),
                onTap: () {
                  if (_get[index]['status_pemesanan'] == 'Selesai') {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Status Pembayaran'),
                        content:
                            const Text('Selamat pembayaran anda telah lunas'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayPage(
                          nama_paket: _get[index]['nama_paket'].toString(),
                          total_bayar: _get[index]['total_bayar'].toString(),
                          status_pemesanan: _get[index]['status_pemesanan'].toString(),
                          gambar: _get[index]['gambar'].toString(),
                          keterangan: _get[index]['keterangan'].toString(),
                          full_name: _get[index]['full_name'].toString(),
                          redirect_url: _get[index]['redirect_url'].toString(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        drawer: MenuPage(),
      ),
    );
  }
}