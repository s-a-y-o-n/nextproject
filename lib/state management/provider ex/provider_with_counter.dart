import 'package:flutter/material.dart';
import 'package:nextproject/state%20management/provider%20ex/controller/counter_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (context) => CounterProvider(), child: Counter_provider_ex()),
  ));
}

class Counter_provider_ex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counterController = Provider.of<CounterProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Increment counter'),
            Text('Counter Value : ${counterController.counter_value.value}'),
            ElevatedButton(
                onPressed: () {
                  counterController.increment_count();
                },
                child: Text('Increment value'))
          ],
        ),
      ),
    );
  }
}
