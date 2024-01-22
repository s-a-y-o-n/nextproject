import 'package:flutter/material.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/fire_functions.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/login_fire.dart';

class Home_fire extends StatelessWidget {
  const Home_fire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseHelper().logout().then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login_fire())));
            },
            child: Text('Logout')),
      ),
    );
  }
}
