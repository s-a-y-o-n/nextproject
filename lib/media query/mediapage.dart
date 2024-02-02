import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Media_page(),
  ));
}

class Media_page extends StatelessWidget {
  const Media_page({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool islargescreen = width > 600;
    return Scaffold(
      body: islargescreen == true ? Bigscreen() : Mobilescreen(),
    );
  }
}

class Bigscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bigscreen'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(color: Colors.green[200]),
                  ),
                ),
                Expanded(child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: Colors.green[100],
                      child: Text('Video $index'),
                    ),
                  );
                }))
              ],
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.blue[100],
                child: Text('Video $index'),
              ),
            );
          }))
        ],
      ),
    );
  }
}

class Mobilescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(color: Colors.green[200]),
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.green[100],
                child: Text('Video $index'),
              ),
            );
          }))
        ],
      ),
    );
  }
}
