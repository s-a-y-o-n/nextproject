import 'package:flutter/material.dart';

class StatefulScreen extends StatefulWidget {
  String name, place;
  StatefulScreen({super.key, required this.name, required this.place});

  @override
  State<StatefulScreen> createState() => _StatefulScreenState();
}

class _StatefulScreenState extends State<StatefulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${widget.name}    ${widget.place}"),
      ),
    );
  }
}
