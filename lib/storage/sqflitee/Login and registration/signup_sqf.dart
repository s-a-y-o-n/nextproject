import 'package:flutter/material.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/login_sqf.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/sqflite_functions.dart';

class Signup_sqf extends StatelessWidget {
  var name_ctrl = TextEditingController();
  var email_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  controller: name_ctrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                ),
              ),
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
              TextFormField(
                  controller: pass_ctrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return "Invalid password";
                    }
                  }),
              ElevatedButton(
                  onPressed: () async {
                    var valid = formkey.currentState!.validate();
                    if (valid == true) {
                      var users = await SQL_function.checkuserAlreadyRegistered(
                          email_ctrl.text);
                      if (users.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('This email is already registered')));
                      } else {
                        registeruser(name_ctrl.text, email_ctrl.text,
                            pass_ctrl.text, context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Fill the fields in correct format')));
                    }
                  },
                  child: Text('SignUp')),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login_sqf()));
                  },
                  child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }

  void registeruser(
      String name, String email, String pass, BuildContext context) async {
    var id = await SQL_function.adduser(
        name, email, pass); //id of the inserted data will be assigned here
    print(id);
    if (id != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login_sqf()));
    }
  }
}
