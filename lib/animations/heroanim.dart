import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HeroAnim(),
  ));
}

class HeroAnim extends StatelessWidget {
  const HeroAnim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Main Page'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HeroDetails()));
        },
        child: Hero(
          tag: 'imagehero',
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.tour,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HeroAnim()));
          },
          child: Hero(
            tag: 'imagehero',
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueGrey),
              child: Icon(
                Icons.tour,
                size: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
