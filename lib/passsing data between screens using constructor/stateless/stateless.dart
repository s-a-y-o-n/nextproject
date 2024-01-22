import 'package:flutter/material.dart';

class StatelessScreen extends StatelessWidget {
  String name, place;

  StatelessScreen({super.key, required this.name, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$name   $place"),
      ),
    );
  }
}
