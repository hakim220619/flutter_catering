import 'package:catering/register/service/service_register.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String email;
  late String fullName;
  late String password;
  late String username;
  late String noHp;
  late String role;
  late String alamat;
  var jenis_kelamin;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Register')),
      body: Container(
        margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Username';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Masukan Username',
                    hintText: 'Masukan Username'),
                onChanged: (value) {
                  setState(() {
                    username = value;
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
                    return 'Masukan Full name';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon:
                        const Icon(Icons.supervised_user_circle_outlined),
                    labelText: 'Masukan Full Name',
                    hintText: 'Masukan Full Name'),
                onChanged: (value) {
                  setState(() {
                    fullName = value;
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
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nomor Hp';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
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
                height: 10,
              ),
              TextFormField(
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Alamat';
                  }
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.add_home_work),
                    labelText: 'Masukan Alamat',
                    hintText: 'Masukan Alamat'),
                onChanged: (value) {
                  setState(() {
                    alamat = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(1.0),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    prefixIcon: const Icon(Icons.emoji_people_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  items: <String>['Laki-laki', 'Perempuan'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) return 'Silahkan Masukan Jenis Kelamin';
                    return null;
                  },
                  hint: new Text("Pilih Jenis Kelamin"),
                  value: jenis_kelamin,
                  onChanged: (value) {
                    setState(() {
                      jenis_kelamin = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await HttpService.register(username, email, fullName,
                          password, noHp, alamat, jenis_kelamin, context);
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
