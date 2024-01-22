import 'package:flutter/material.dart';

class Second_pageanimation extends StatelessWidget {
  const Second_pageanimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Main page')),
      ),
    );
  }
}
