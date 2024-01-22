import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCtgIuQTPbrNqS60M6EJNTVBXMiLe_y7bg",
          appId: "1:820125485637:android:0a35c55bc1b1841d2ab12c",
          messagingSenderId: "",
          projectId: "project-firebase-25487",
          storageBucket: "project-firebase-25487.appspot.com"));

  runApp(MaterialApp(
    home: FirebaseCurd(),
  ));
}

class FirebaseCurd extends StatefulWidget {
  const FirebaseCurd({super.key});

  @override
  State<FirebaseCurd> createState() => _FirebaseCurdState();
}

class _FirebaseCurdState extends State<FirebaseCurd> {
  var name_ctrl = TextEditingController();
  var email_ctrl = TextEditingController();
  late CollectionReference _userCollection;

  @override
  void initState() {
    _userCollection = FirebaseFirestore.instance.collection("users");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Cloud storage'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: name_ctrl,
            decoration: InputDecoration(hintText: 'Enter the name'),
          ),
          TextField(
            controller: email_ctrl,
            decoration: InputDecoration(hintText: 'Enter the Email'),
          ),
          ElevatedButton(
              onPressed: () {
                addUser();
              },
              child: Text('Add User')),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final users = snapshot.data!.docs;
                return Expanded(
                    child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final userid = user.id;
                          final username = user["name"];
                          final useremail = user["email"];
                          return ListTile(
                            title: Text('$username'),
                            subtitle: Text('$useremail'),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      edituser(userid, username, useremail);
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteuser(userid);
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                          );
                        }));
              })
        ],
      ),
    );
  }

  Future<void> addUser() async {
    return _userCollection
        .add({'name': name_ctrl.text, 'email': email_ctrl.text}).then((value) {
      print("User added");
      name_ctrl.clear();
      email_ctrl.clear();
    }).catchError((error) {
      print("Failed to add user $error");
    });
  }

  Stream<QuerySnapshot> getUser() {
    return _userCollection.snapshots();
  }

  void edituser(var id, name, email) {
    showDialog(
        context: context,
        builder: (context) {
          var newnamectrl = TextEditingController();
          var newemailctrl = TextEditingController();
          newnamectrl.text = name;
          newemailctrl.text = email;

          return AlertDialog(
            title: Text('Update User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newnamectrl,
                  decoration: InputDecoration(hintText: 'Enter Name'),
                ),
                TextField(
                  controller: newemailctrl,
                  decoration: InputDecoration(hintText: 'Enter Email'),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateuser(id, newnamectrl.text, newemailctrl.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }

  Future<void> updateuser(var id, String name, String email) async {
    return _userCollection
        .doc(id)
        .update({'name': name, 'email': email}).then((value) {
      print('User Updated');
    }).catchError((error) {
      print('Updation Failed $error');
    });
  }

  Future<void> deleteuser(var id) async {
    return _userCollection.doc(id).delete().then((value) {
      print('User Deleted');
    }).catchError((onError) {
      print('Cant delete $onError');
    });
  }
}
