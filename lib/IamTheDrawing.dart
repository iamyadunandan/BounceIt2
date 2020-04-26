import 'package:flutter/material.dart';

import 'IamTheCustomePainter.dart';

class IamTheDrawing extends StatefulWidget {
  IamTheDrawing({Key key}) : super(key: key);

  @override
  _IamTheDrawingState createState() => _IamTheDrawingState();
}

class _IamTheDrawingState extends State<IamTheDrawing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amberAccent,
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return ClipRRect(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxWidth / (4 / 3.0),
              child: LayoutBuilder(builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    //background layer
                    CustomPaint(
                      size: constraints.biggest,
                      painter: IamTheBackgroundPainter(),
                    ),
                    //cloud layer with sun/moon
                    Stack(
                      children: <Widget>[
                        //cloud with sun/moon
                        Align(
                          //cloud alignment position
                          alignment: Alignment(
                            constraints.maxWidth * -.6 / constraints.maxWidth,
                            constraints.maxHeight *
                                -.14 /
                                constraints.maxHeight,
                          ),
                          child: Container(
                            height: constraints.maxWidth * 0.1,
                            width: constraints.maxWidth * 0.2,
                            child: CustomPaint(
                              foregroundPainter: IamTheCloudPainter(
                                  isSingle: false, cloudColor: Colors.blueGrey),
                              painter:
                                  IamTheSunMoonPainter(sunColor: Colors.white),
                            ),
                          ),
                        ),
                        Align(
                          //cloud alignment position
                          alignment: Alignment(
                            constraints.maxWidth * .3 / constraints.maxWidth,
                            constraints.maxHeight *
                                -0.7 /
                                constraints.maxHeight,
                          ),
                          child: Container(
                            height: constraints.maxWidth * 0.08,
                            width: constraints.maxWidth * 0.16,
                            child: CustomPaint(
                              foregroundPainter: IamTheCloudPainter(
                                  isSingle: false, cloudColor: Colors.blueGrey),
                              //painter: IamTheSunMoonPainter(),
                            ),
                          ),
                        ),
                        Align(
                          //cloud alignment position
                          alignment: Alignment(
                            constraints.maxWidth * -.9 / constraints.maxWidth,
                            constraints.maxHeight *
                                -0.2 /
                                constraints.maxHeight,
                          ),
                          child: Container(
                            height: constraints.maxWidth * 0.04,
                            width: constraints.maxWidth * 0.08,
                            child: CustomPaint(
                              foregroundPainter: IamTheCloudPainter(
                                  isSingle: true, cloudColor: Colors.blueGrey),
                              //painter: IamTheSunMoonPainter(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //earth
                    Stack(
                      children: <Widget>[
                        //globe
                        Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: CustomPaint(
                            painter: IamTheEarthPainter(
                              earthColor: Colors.blueGrey[400],
                            ),
                          ),
                        ),
                        //tree
                        Align(
                          alignment: Alignment(-.9, .8),
                          child: Container(
                            //color: Colors.red,
                            width: constraints.maxWidth * .22,
                            height: constraints.maxHeight * .15,
                            child: CustomPaint(
                              painter: IamTreeThePainter(
                                  gradient1: Colors.cyan,
                                  gradient2: Colors.cyan[900],
                                  treeBark: Colors.blueGrey[800]),
                            ),
                          ),
                        ),
                        //tree
                        Align(
                          alignment: Alignment(-.2, .15),
                          child: Container(
                            //color: Colors.red,
                            width: constraints.maxWidth * .11,
                            height: constraints.maxHeight * .08,
                            child: CustomPaint(
                              painter: IamTreeThePainter(
                                  gradient1: Colors.cyan,
                                  gradient2: Colors.cyan[900],
                                  treeBark: Colors.blueGrey[800]),
                            ),
                          ),
                        ),
                        //tree
                        Align(
                          alignment: Alignment(.9, -.3),
                          child: Container(
                            //color: Colors.red,
                            width: constraints.maxWidth * .1,
                            height: constraints.maxHeight * .08,
                            child: CustomPaint(
                              painter: IamTreeThePainter(
                                  gradient1: Colors.cyan,
                                  gradient2: Colors.cyan[900],
                                  treeBark: Colors.blueGrey[800]),
                            ),
                          ),
                        ),
                        //tree
                        Align(
                          alignment: Alignment(1.2, 1.0),
                          child: Container(
                            //color: Colors.red,
                            width: constraints.maxWidth * .3,
                            height: constraints.maxHeight * .22,
                            child: CustomPaint(
                              painter: IamTreeThePainter(
                                  gradient1: Colors.cyan,
                                  gradient2: Colors.cyan[900],
                                  treeBark: Colors.blueGrey[800]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //homes
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment(0, 0),
                          child: Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            alignment: Alignment.center,
                            //color: Colors.red,
                            child: CustomPaint(
                              painter: IamTheCloudPainter(cloudColor: Colors.red,isSingle: false),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
