import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Datepick(),
  ));
}

class Datepick extends StatefulWidget {
  Datepick({super.key});

  @override
  State<Datepick> createState() => _DatepickState();
}

class _DatepickState extends State<Datepick> {
  var selecteddate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: TextEditingController(
                text: "${selecteddate.toLocal()}".split(" ")[0]),
            onTap: () => selectDate(context),
            decoration:
                InputDecoration(suffixIcon: Icon(Icons.calendar_month_rounded)),
          )
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickeddate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(3000));
    if (pickeddate != null && pickeddate != selecteddate) {
      setState(() {
        selecteddate = pickeddate;
      });
    }
  }
}
