import 'package:flutter/material.dart';
import 'package:nextproject/state%20management/use%20of%20multi%20provider/provider/auth_provider.dart';
import 'package:nextproject/state%20management/use%20of%20multi%20provider/provider/counter_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Count_provider()),
        ChangeNotifierProvider(create: (context) => Auth_provider())
      ],
      child: Multi_provider(),
    ),
  ));
}

class Multi_provider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Counter Value',
            style: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
              onPressed: () {
                Provider.of<Count_provider>(context, listen: false).increment();
              },
              child: Text('increment')),
          Text("Count value : ${Provider.of<Count_provider>(context).count}"),
          SizedBox(height: 20),
          Text('Details'),
          ElevatedButton(
              onPressed: () {
                Provider.of<Auth_provider>(context, listen: false).login
                    ? Provider.of<Auth_provider>(context, listen: false)
                        .logedout()
                    : Provider.of<Auth_provider>(context, listen: false)
                        .logedin();
              },
              child: Text('switch')),
          Consumer<Auth_provider>(builder: (context, authprovider, child) {
            return Text(
                "User is ${authprovider.login ? 'Logged in' : 'Logged out'}");
          })
        ],
      ),
    );
  }
}
