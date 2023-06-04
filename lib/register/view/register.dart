import 'package:catering/register/service/service_register.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String email;
  late String password;
  late String nama;
  late String noHp;
  late String role;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama Lengkap';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Masukan Nama',
                    hintText: 'Masukan Nama'),
                onChanged: (value) {
                  setState(() {
                    nama = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Email';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Masukan Email',
                    hintText: 'Masukan Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Password';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = _passwordVisible ? false : true;
                        });
                      },
                      child: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    prefixIcon: const Icon(Icons.key),
                    labelText: 'Masukan Password',
                    hintText: 'Masukan Password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nomor Hp';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    labelText: 'Masukan Nomor Hp',
                    hintText: 'Masukan Nomor Hp'),
                onChanged: (value) {
                  setState(() {
                    noHp = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await HttpService.register(
                          email, password, nama, noHp, context);
                    }
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(9, 107, 199, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
