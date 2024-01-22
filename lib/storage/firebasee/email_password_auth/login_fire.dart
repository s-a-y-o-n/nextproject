import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/fire_functions.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/home_fire.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/phoneauth.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/registeration_fire.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCtgIuQTPbrNqS60M6EJNTVBXMiLe_y7bg",
          appId: "1:820125485637:android:0a35c55bc1b1841d2ab12c",
          messagingSenderId: "",
          projectId: "project-firebase-25487"));
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? Login_fire() : Home_fire(),
    debugShowCheckedModeBanner: false,
  ));
}

class Login_fire extends StatelessWidget {
  var email_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Here',
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
                      .loginuser(email: email, password: pwd)
                      .then((result) {
                    if (result == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home_fire()));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    }
                  });
                },
                child: Text('Login')),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register_fire()));
                },
                child: Text(
                  'Dont Have an Account?',
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Phoneauth()));
                },
                child: Text('Continue With Phone No.'))
          ],
        ),
      ),
    );
  }
}
