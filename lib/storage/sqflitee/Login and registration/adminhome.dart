import 'package:flutter/material.dart';
import 'package:nextproject/storage/sqflitee/Login%20and%20registration/sqflite_functions.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  List<Map<String, dynamic>> users = [];
  @override
  void initState() {
    getAllusers();
    super.initState();
  }

  void getAllusers() async {
    var usersfromdb = await SQL_function.readAllData();
    setState(() {
      users = usersfromdb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text('${users[index]["id"]}'),
                title: Text(users[index]["name"]),
                subtitle: Text(users[index]["email"]),
                trailing: IconButton(
                    onPressed: () {
                      deleteuser(users[index]["id"]);
                    },
                    icon: Icon(Icons.delete)),
              ),
            );
          }),
    );
  }

  void deleteuser(int id) async {
    await SQL_function.deleteUser(id);
    getAllusers(); // to refresh
  }
}
