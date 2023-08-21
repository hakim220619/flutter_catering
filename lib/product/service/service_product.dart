import 'dart:convert';
import 'dart:math';
import 'package:catering/transaksi/view/transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: unused_import
// import 'package:catering/pay/view/pay.dart';
// import 'package:catering/transaksi/view/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:catering/product/service/data.dart';

class ServiceProduct {
  static var _pesanmidtransUrl =
      Uri.parse('https://app.sandbox.midtrans.com/snap/v1/transactions');

  static var _pesanUrl =
      Uri.parse("https://katering.eastbluetechnology.com/api/pemesanan");

  static pesan(id, jumlah, harga, dateofJourney, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_user = prefs.getString('id_user');
    var token = prefs.getString('token');
// print(int.parse(jumlah));
    // print(id_user);
    Random objectname = Random();
    int number = objectname.nextInt(10000000);

    String username = 'SB-Mid-server-z5T9WhivZDuXrJxC7w-civ_k';
    String password = '';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    http.Response responseMidtrans = await http.post(_pesanmidtransUrl,
        headers: <String, String>{
          'authorization': basicAuth,
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'transaction_details': {
            'order_id': number,
            'gross_amount': int.parse(jumlah) * int.parse(harga)
          },
          "credit_card": {"secure": true}
        }));
    var jsonMidtrans = jsonDecode(responseMidtrans.body.toString());
    print(dateofJourney);

    http.Response response = await http.post(_pesanUrl, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer " + token.toString(),
    }, body: {
      "idUser": id_user.toString(),
      "idPaket": id.toString(),
      "jumlah_pesan": jumlah.toString(),
      "harga": harga.toString(),
      "untuk_tanggal": dateofJourney.toString(),
      "status": "belum bayar",
      "order_id": number.toString(),
      "redirect_url": jsonMidtrans['redirect_url'].toString(),
    });
    print(response.body);
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      var json = jsonDecode(response.body.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransaksiPage()),
      );
    }
  }
}
