import 'package:flutter/material.dart';
import 'package:nextproject/storage/shared%20preference/login%20and%20registration/home.dart';
import 'package:nextproject/storage/shared%20preference/login%20and%20registration/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formkey = GlobalKey<FormState>();
  var user_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();
  late bool newuser;
  late SharedPreferences preferences;
  @override
  void initState() {
    checklogin();
    super.initState();
  }

  void checklogin() async {
    preferences = await SharedPreferences.getInstance();
    newuser = preferences.getBool("newuser") ?? true;
    if (newuser == false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Username'),
                  validator: (username) {
                    if (username!.isEmpty || !username.contains("@")) {
                      return "Invalid Username";
                    } else {
                      return null;
                    }
                  },
                  controller: user_ctrl,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  controller: pass_ctrl,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return "Password is empty/ Password must contain atleast 6 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      var valid = formkey.currentState!.validate();
                      if (valid == true) {
                        getdata();
                      }
                    },
                    child: Text('Login')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      'Dont have account? Signup',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            )),
      ),
    ));
  }

  void getdata() async {
    String uname = user_ctrl.text;
    String password = pass_ctrl.text;
    preferences = await SharedPreferences.getInstance();
    preferences.setBool("newuser", false);
    String? reguname = preferences.getString("uname");
    String? regpass = preferences.getString("password");
    if (uname == reguname && password == regpass) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
