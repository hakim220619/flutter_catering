import 'dart:ffi';

import 'package:flutter/material.dart';

import '../service/service_product.dart';
// import 'package:catering/product/service/service_product.dart';

class DetailProduct extends StatefulWidget {
  final String id;
  final String nama_paket;
  final String harga;
  final String stok;
  final String gambar;
  final String keterangan;
  final String created_at;
  const DetailProduct(
      {Key? key,
      required this.id,
      required this.nama_paket,
      required this.harga,
      required this.gambar,
      required this.stok,
      required this.keterangan,
      required this.created_at})
      : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

late String jumlah;

class _DetailProductState extends State<DetailProduct> {
  TextEditingController NamaBarang = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  // TextEditingController Email = TextEditingController();
  // TextEditingController Nohp = TextEditingController();
  @override
  void dispose() {
    _formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(String title, String text, String nobutton,
        String yesbutton, Function onTap, bool isValue) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: isValue,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(nobutton),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(yesbutton),
                onPressed: () async {
                  await ServiceProduct.pesan(widget.id.toString(),
                      jumlah.toString(), widget.harga.toString(), context);
                },
              ),
            ],
          );
        },
      );
    }

    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SafeArea(
        child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Container(
                      child: Column(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                '${widget.gambar.toString()}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: widget.nama_paket.toString(),
                            onChanged: (value) {
                              setState(() {
                                jumlah = value;
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Nama Paket",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Nama Paket"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nama Paket Pembelian tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: widget.keterangan.toString(),
                            onChanged: (value) {
                              setState(() {
                                jumlah = value;
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Keterangan",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Keterangan"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Keterangan Pembelian tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: widget.harga.toString(),
                            onChanged: (value) {
                              setState(() {
                                jumlah = value;
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Harga",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Harga"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Harga Pembelian tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: NamaBarang,
                            onChanged: (value) {
                              setState(() {
                                jumlah = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Masukan Jumlah Pembelian",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Jumlah"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Jumlah Pembelian tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        if (int.parse(widget.stok) < int.parse(jumlah)) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Peringatan'),
                              content: const Text(
                                  'Jumlah tidak boleh lebih dari Stok'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (_formkey.currentState!.validate()) {
                          _showMyDialog(
                              'Detail Pesanan',
                              'Pesanan anda sudah benar?',
                              'No',
                              'Yes',
                              () async {},
                              false);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Center(
                          child: Text(
                            "Pesan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(25)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
