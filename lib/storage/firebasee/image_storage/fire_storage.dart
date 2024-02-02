import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

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
    home: Img_Storage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Img_Storage extends StatefulWidget {
  const Img_Storage({super.key});

  @override
  State<Img_Storage> createState() => _Img_StorageState();
}

class _Img_StorageState extends State<Img_Storage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Storage"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    upload("camera");
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      upload("gallery");
                    },
                    icon: Icon(Icons.file_upload),
                    label: Text('Upload'))
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: loadmedia(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final image = snapshot.data?[index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(image?['imageurl']),
                                subtitle: Text(image?['time']),
                                trailing: IconButton(
                                    onPressed: () {
                                      deletemedia(image?['path']);
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }))
        ],
      ),
    );
  }

  Future<void> upload(String imagefrom) async {
    final picker = ImagePicker();
    XFile? pickedimage;
    try {
      pickedimage = await picker.pickImage(
          source:
              imagefrom == "camera" ? ImageSource.camera : ImageSource.gallery);
      final String filename = path.basename(pickedimage!.path);
      File imagefile = File(pickedimage.path);
      try {
        await storage.ref(filename).putFile(
            imagefile,
            SettableMetadata(customMetadata: {
              'uploadedby': "Phone Name",
              'time': "${DateTime.now()}"
            }));
      } on FirebaseException catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> loadmedia() async {
    List<Map<String, dynamic>> images = [];
    final ListResult result = await storage.ref().list();
    final List<Reference> allfiles = result.items;
    await Future.forEach(allfiles, (element) async {
      final String fileurl = await element.getDownloadURL();
      final FullMetadata metadata = await element.getMetadata();
      images.add({
        'imageurl': fileurl,
        'path': element.fullPath,
        'uploadedby': metadata.customMetadata?['uploadedby'] ?? "Nodata",
        'time': metadata.customMetadata?['time'] ?? "No time found"
      });
    });
    return images;
  }

  Future<void> deletemedia(String imagepath) async {
    await storage.ref(imagepath).delete();
    setState(() {});
  }
}
