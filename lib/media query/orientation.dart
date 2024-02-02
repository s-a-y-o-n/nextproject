import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyScreen());
}

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // to know the theme of device
    var isdark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MaterialApp(
      theme: isdark == true ? ThemeData.dark() : ThemeData.light(),
      home: OrientationPage(),
    );
  }
}

class OrientationPage extends StatelessWidget {
  const OrientationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: orientation == Orientation.portrait ? ListScreen() : GridScreen(),
    );
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(13),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1706068720402-ce49bf8661be?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8"),
                    fit: BoxFit.fill)),
          ),
        );
      }),
    );
  }
}

class GridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gridview'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(
            20,
            (index) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
                  child: Center(
                    child: Text('Grid $index', style: TextStyle(fontSize: 27)),
                  ),
                )),
      ),
    );
  }
}
