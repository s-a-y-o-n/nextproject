import 'package:flutter/material.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/fire_functions.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/login_fire.dart';

class Register_fire extends StatelessWidget {
  var email_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register Here',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(169, 61, 4, 0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: email_ctrl,
                decoration: InputDecoration(hintText: 'Enter Your Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: pass_ctrl,
                decoration: InputDecoration(hintText: 'Enter Your Password'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String email = email_ctrl.text.trim();
                  String pwd = pass_ctrl.text.trim();
                  FirebaseHelper()
                      .registeruser(email: email, password: pwd)
                      .then((result) {
                    if (result == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login_fire()));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    }
                  });
                },
                child: Text('Register')),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login_fire()));
                },
                child: Text(
                  'Already Have an Account?',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
