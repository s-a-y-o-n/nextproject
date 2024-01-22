import 'package:flutter/material.dart';
import 'package:nextproject/storage/shared%20preference/login%20and%20registration/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formkey = GlobalKey<FormState>();
  var user_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();
  var phone_ctrl = TextEditingController();
  late SharedPreferences preference;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (username) {
                    if (username!.isEmpty || !username.contains("@")) {
                      return "Invalid Username";
                    } else {
                      return null;
                    }
                  },
                  controller: user_ctrl,
                  decoration: InputDecoration(hintText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (phone) {
                    if (phone!.isEmpty || phone.length < 10) {
                      return "Ph no is empty/ Password must contain atleast 10 characters";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Phone No"),
                  controller: phone_ctrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return "Password is empty/ Password must contain atleast 6 characters";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Password"),
                  controller: pass_ctrl,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    var valid = formkey.currentState!.validate();
                    if (valid == true) {
                      storedata();
                    }
                  },
                  child: Text('Signup')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("login"))
            ],
          )),
    ));
  }

  void storedata() async {
    String email = user_ctrl.text.trim();
    String password = pass_ctrl.text;
    int phone = int.parse(phone_ctrl.text);
    preference = await SharedPreferences.getInstance();
    preference.setString("uname", email);
    preference.setString("password", password);
    preference.setInt("phone", phone);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }
}
