import 'package:flutter/material.dart';
import 'package:nextproject/passsing%20data%20between%20screens%20using%20constructor/statefull/statefullscreen.dart';
import 'package:nextproject/passsing%20data%20between%20screens%20using%20constructor/stateless/stateless.dart';

void main() {
  runApp(MaterialApp(
    home: Datahome(),
  ));
}

class Datahome extends StatelessWidget {
  String name = 'kkkkk';
  String place = 'hhddhdhdh';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatelessScreen(name: name, place: place)));
                },
                child: Text('To Stateless Screen')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatefulScreen(name: name, place: place)));
                },
                child: Text('To Statefull'))
          ],
        ),
      ),
    );
  }
}
