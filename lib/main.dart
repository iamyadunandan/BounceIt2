import 'dart:developer';

import 'package:flutter/material.dart';

import 'IamTheDrawing.dart';
import 'IamTheCustomePainter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // This widget is the root of your application.

  AnimationController _animController;
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this);
    _animController.duration = Duration(seconds: 2);
    _animController.addStatusListener((st) {
      if (st == AnimationStatus.completed) {}
    });
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheDayNightBounce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onDoubleTap: () {
            if (_animController.isDismissed) {
              _animController.forward();
            } else if (_animController.isCompleted) {
              _animController.reverse();
            }
          },
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              IamTheDrawing(
                animationController: _animController,
                day: false,
              ),
              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return ClipRect(
                    child: Container(
                      height: constraints.maxHeight * 2 / (4.0 / 3.0),
                      width: constraints.maxWidth * (1 - _animController.value),
                      alignment: Alignment.center,
                      child: OverflowBox(
                        alignment: Alignment.centerRight,
                        maxWidth: constraints.maxWidth,
                        maxHeight: constraints.maxHeight / (4.0 / 3.0),
                        child: IamTheDrawing(
                          animationController: _animController,
                          day: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
