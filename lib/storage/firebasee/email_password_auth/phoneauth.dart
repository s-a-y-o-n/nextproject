import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/fire_functions.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/otp_screen.dart';

class Phoneauth extends StatefulWidget {
  Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  var phonectrl = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Phone Authentication",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: phonectrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Phone No'),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await auth.verifyPhoneNumber(
                      phoneNumber: phonectrl.text.toString(),
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {
                        ScaffoldMessenger(child: Text(e.toString()));
                      },
                      codeSent: (String verificationid, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Otp_screen(otp: verificationid)));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        ScaffoldMessenger(child: Text(e.toString()));
                      });
                },
                child: Text('Get Otp'))
          ],
        ),
      ),
    );
  }
}
