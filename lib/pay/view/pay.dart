import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:catering/home/view/home.dart';
// ignore: unused_import
import 'package:catering/transaksi/view/transaksi_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PayPage extends StatefulWidget {
  const PayPage({
    Key? key,
    required this.nama_paket,
    required this.total_bayar,
    required this.status_pemesanan,
    required this.gambar,
    required this.keterangan,
    required this.full_name,
    required this.redirect_url,
  }) : super(key: key);
  final String nama_paket;
  final String total_bayar;
  final String status_pemesanan;
  final String gambar;
  final String keterangan;
  final String full_name;
  final String redirect_url;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pembayaran"),
          leading: InkWell(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const TransaksiPage(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(253, 255, 252, 252),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      widget.nama_paket,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.numbers,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      widget.total_bayar,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.description,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      widget.keterangan,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.payment,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      widget.status_pemesanan,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.redAccent[50],
                child: Center(
                    child: ElevatedButton(
                  child: Text("Bayar Sekarang"),
                  onPressed: () async {
                    String url = widget.redirect_url;
                    var urllaunchable = await canLaunch(
                        url); //canLaunch is from url_launcher package
                    if (urllaunchable) {
                      await launch(
                          url); //launch is from url_launcher package to launch URL
                    } else {
                      print("URL can't be launched.");
                    }
                  },
                )),
              ),
            ],
          ),
        ));
  }
}