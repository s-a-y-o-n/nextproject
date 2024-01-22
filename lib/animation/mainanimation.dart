import 'package:flutter/material.dart';
import 'package:nextproject/animation/second_pageanimation.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MaterialApp(
    home: Main_animation(),
  ));
}

class Main_animation extends StatelessWidget {
  const Main_animation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryanimation) {
                            return Second_pageanimation();
                          },
                          transitionsBuilder:
                              (context, animation, animation2, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500)));
                },
                child: Text('Fade animation')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryanimation) {
                            return Second_pageanimation();
                          },
                          transitionsBuilder:
                              (context, animation, animation2, child) {
                            return ScaleTransition(
                              scale: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(animation),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(seconds: 1)));
                },
                child: Text('Scale Animation')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Second_pageanimation();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(-1.0, 0.0),
                                end: const Offset(0.0, 0.0),
                              ).animate(animation),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(seconds: 1)));
                },
                child: Text('Slide animation')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Second_pageanimation(),
                          type: PageTransitionType.topToBottom,
                          childCurrent: this,
                          duration: Duration(seconds: 1)));
                },
                child: Text('Using package'))
          ],
        ),
      ),
    );
  }
}
