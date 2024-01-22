import 'package:flutter/material.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/sqflite_functions.dart';

class Userhome extends StatefulWidget {
  final data;
  const Userhome({super.key, required this.data});
  @override
  State<Userhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  var name, email;
  @override
  void initState() {
    name = widget.data[0]["name"];
    email = widget.data[0]["email"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var email_ctrl = TextEditingController();
    var name_ctrl = TextEditingController();

    void updateuser() async {
      await SQL_function.updatedata(widget.data[0]["id"], name, email);
    }

    void editdata() {
      setState(() {
        name_ctrl.text = name;
        email_ctrl.text = email;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Edit Data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name_ctrl,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: email_ctrl,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          name = name_ctrl.text;
                          email = email_ctrl.text;
                        });
                        updateuser();
                        Navigator.of(context).pop();
                      },
                      child: Text('Update'))
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $name"),
      ),
      body: Card(
        child: ListTile(
          leading: Icon(Icons.person_4_rounded),
          title: Text('$name'),
          subtitle: Text('$email'),
          trailing: IconButton(
              onPressed: () {
                editdata();
              },
              icon: Icon(Icons.edit)),
        ),
      ),
    );
  }
}
