import 'package:flutter/material.dart';
import 'package:nextproject/state%20management/provider%20ex/controller/theme_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: Myapp1()));
}

class Myapp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).isdarktheme
          ? ThemeData.dark()
          : ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: AppThemechange(),
    );
  }
}

class AppThemechange extends StatelessWidget {
  const AppThemechange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).switchtheme();
            },
            child: Text('Switch theme')),
      ),
    );
  }
}
