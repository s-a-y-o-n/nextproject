import 'package:flutter/material.dart';
import 'package:nextproject/state%20management/provider%20ex/controller/counter_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (context) => CounterProvider(), child: Consumer_ex()),
  ));
}

class Consumer_ex extends StatelessWidget {
  const Consumer_ex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Value'),
            Consumer<CounterProvider>(
                builder: (context, counterProvider, child) {
              return Text(
                '${counterProvider.counter_value.value}',
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false)
              .increment_count();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
