import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: PermissionScreen(),
  ));
}

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                camerapermission(context);
              },
              child: Text('Camera')),
          Spacer(
            flex: 1,
          ),
          ElevatedButton(
              onPressed: () {
                askmultiplepermission();
              },
              child: Text('Multiple Permissions')),
          Spacer(
            flex: 1,
          ),
          ElevatedButton(
              onPressed: () {
                openappsetings();
              },
              child: Text('Settings')),
        ],
      ),
    );
  }

  void camerapermission(BuildContext context) async {
    var status = await Permission.camera.status;
    if (await Permission.camera.request().isGranted) {
      var picker = ImagePicker();
      picker.pickImage(source: ImageSource.camera);
    } else if (status.isDenied) {
      ScaffoldMessenger(child: Text('permission denied'));
    }
  }

  void openappsetings() async {
    openAppSettings();
  }

  void askmultiplepermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.contacts,
      Permission.mediaLibrary,
      Permission.phone,
      Permission.microphone,
      Permission.photos
    ].request();
    print('status location ${status[Permission.location]}');
  }
}
