import 'package:flutter/material.dart';
import 'package:nextproject/storage/shared%20preference/login%20and%20registration/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences preferences;
  late String? username;

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  void fetchdata() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("uname");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $username"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                preferences.setBool("newuser", true);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text('Logout'))),
    );
  }
}
