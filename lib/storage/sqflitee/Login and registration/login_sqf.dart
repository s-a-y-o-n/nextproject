import 'package:flutter/material.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/adminhome.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/signup_sqf.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/sqflite_functions.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/userhome.dart';

void main() {
  runApp(MaterialApp(
    home: Login_sqf(),
    debugShowCheckedModeBanner: false,
  ));
}

class Login_sqf extends StatelessWidget {
  var email_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void loginuser(String email, String pass) async {
      if (email == "admin@gmail.com" && pass == "admin123") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Adminhome()));
      } else {
        //check if the user is awailable
        var data = await SQL_function.checkuserExist(email, pass);
        if (data.isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Userhome(data: data)));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(11),
                child: TextFormField(
                  controller: email_ctrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email'),
                  validator: (email) {
                    if (email!.isEmpty || !email.contains('@')) {
                      return "Invalid email";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11),
                child: TextFormField(
                    controller: pass_ctrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Password'),
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return "Invalid password";
                      }
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    var valid = formkey.currentState!.validate();
                    if (valid) {
                      loginuser(email_ctrl.text, pass_ctrl.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid Input')));
                    }
                  },
                  child: Text('LogIn')),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup_sqf()));
                  },
                  child: Text('Register here'))
            ],
          ),
        ),
      ),
    );
  }
}
