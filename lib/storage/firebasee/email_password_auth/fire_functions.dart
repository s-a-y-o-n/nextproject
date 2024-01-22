import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nextproject/storage/firebasee/email_password_auth/otp_screen.dart';

class FirebaseHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;
  Future<String?> registeruser(
      {required String email, required String password}) async {
    //string type is given to return the error message
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message; //returns the error message if any
    } catch (e) {
      print(e);
    }
  }

  Future<String?> loginuser(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    auth.signOut();
  }

  // Future<void> phoneauthentication(String phone, BuildContext context) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => Otp_screen(
  //                     otp: verificationId,
  //                   )));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }
}
