import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nextproject/storage/firebasee/email_password_auth/home_fire.dart';

class Otp_screen extends StatefulWidget {
  String otp;
  Otp_screen({super.key, required this.otp});

  @override
  State<Otp_screen> createState() => _Otp_screenState();
}

class _Otp_screenState extends State<Otp_screen> {
  var otpctrl = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OTP Verification",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: otpctrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter the OTP'),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.otp,
                            smsCode: otpctrl.text.toString());

                    await auth.signInWithCredential(credential).then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home_fire()));
                    });
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Text('Verify'))
          ],
        ),
      ),
    );
  }
}
