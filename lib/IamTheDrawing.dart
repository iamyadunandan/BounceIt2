import 'dart:developer';

import 'package:flutter/material.dart';

import 'IamTheCustomePainter.dart';

class IamTheDrawing extends StatefulWidget {
  IamTheDrawing({Key key, @required this.day, this.animationController})
      : super(key: key);
  final bool day;
  final AnimationController animationController;

  @override
  _IamTheDrawingState createState() => _IamTheDrawingState();
}

Color CLOUD_COLOR = Color(0xff8cadff), TREE_G_1 = Color(0xff4abde7);
Color TREE_G_2_COLOR = Color(0xff3984c5), BACKGROUND_G_1 = Color(0xff4384e6);
Color STAR_COLOR = Color(0xfff7b47b);
Color EARTH_COLOR = Color(0xff7bceef);
Color PIPE_TOP = Color(0xff5aadce);
Color PIPE_G_1 = Color(0xff2973ad);
Color PIPE_G_2 = Color(0xff355d9d);
Color SMALL_ROOF_COLOR = Color(0xff2f3a75);
Color SMALL_WALL_COLOR = Color(0xff355d9d);
Color BIG_ROOF_COLOR = Color(0xff355d9d);
Color BIG_WALL_COLOR = Color(0xff3579b4);

Color DAY_CLOUD_COLOR = Color(0xffdd8d7f), DAY_TREE_G_1 = Color(0xff7bd69c);
Color DAY_TREE_G_2_COLOR = Color(0xff6bb58c),
    DAY_BACKGROUND_G_1 = Color(0xfff7b47b);

Color DAY_PIPE_TOP = Color(0xffdd8d7f);
Color DAY_EARTH_COLOR = Color(0xffffd497);
Color DAY_PIPE_G_1 = Color(0xffffd497);
Color DAY_PIPE_G_2 = Color(0xffdd8d7f);
Color DAY_SMALL_ROOF_COLOR = Color(0xffd87461);
Color DAY_SMALL_WALL_COLOR = Color(0xffd87461);
Color DAY_BIG_ROOF_COLOR = Color(0xffd87461);
Color DAY_BIG_WALL_COLOR = Color(0xfff7b47b);

class _IamTheDrawingState extends State<IamTheDrawing>
    with TickerProviderStateMixin {
  bool day;
  Color sunColor,
      cloudColor,
      treeG1Color,
      treeG2Color,
      backGroundG1,
      backGroundG2,
      pipeColor,
      pipeGripColor,
      pipeTipColor,
      smallRoofColor,
      bigRoofColor,
      smallWallColor,
      bigWallColor,
      smokeG1Color,
      smokeG2Color,
      earthColor,
      starColor,
      smokeTipColor,
      bigRoofBarColor,
      switchOffWindowColor,
      windowG1Color,
      windowG2Color,
      waterPipeColor;
  Animation shake1, shake2, shake3;
  AnimationController ac1, ac2, ac3;

  @override
  void initState() {
    super.initState();
    ac1 = AnimationController(
        vsync: this, duration: Duration(seconds: 0, milliseconds: 650));
    ac2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 850));
    ac3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 650));
    makeTweens();
    changeToDay(widget.day);
  }

  Animation<double> getForward(x, add,ac) {
    return TweenSequence<double>(
      [
        TweenSequenceItem<double>(tween: Tween(begin: x, end: x + add), weight: 40),
        TweenSequenceItem<double>(tween: Tween(begin: x + add, end: x), weight: 40),
        TweenSequenceItem<double>(
            tween: Tween(begin: x, end: x + (add / 2)), weight: 20),
        TweenSequenceItem<double>(
            tween: Tween(begin: x + (add / 2), end: x), weight: 20),
      ],
    ).chain(CurveTween(curve: Curves.easeOutSine)).animate(ac);
  }

  Animation<double> getBackward(x,add,ac) {
    return TweenSequence<double>(
      [
        TweenSequenceItem<double>(tween: Tween(begin: x, end: x - add), weight: 40),
        TweenSequenceItem<double>(tween: Tween(begin: x - add, end: x), weight: 40),
        TweenSequenceItem<double>(
            tween: Tween(begin: x, end: x - (add / 2)), weight: 20),
        TweenSequenceItem<double>(
            tween: Tween(begin: x - (add / 2), end: x), weight: 20),
      ],
    ).chain(CurveTween(curve: Curves.easeOutSine)).animate(ac);
  }

  makeTweens() {
    shake1 = getForward(-.9, .1,ac1);

    

    shake2 = getForward(-.6, .2,ac2);

    widget.animationController.addListener(() {
      if ((ac2.isDismissed||ac2.isCompleted)&&(widget.animationController.value * 10).truncate() == 2) {
        ac2.reset();
        if (widget.animationController.status == AnimationStatus.forward) {
          shake2 = getForward(-.6, .2,ac2);
          ac2.forward();
        } else if(widget.animationController.status == AnimationStatus.reverse){
          shake2 = getBackward(-.6, .2,ac2);
          ac2.forward();
        }
      }
    });

    shake3 = getForward(.2, .1,ac3);

    widget.animationController.addListener(() {
      if ((ac3.isDismissed||ac3.isCompleted)&&(widget.animationController.value * 10).truncate() == 5) {
        ac3.reset();
        if (widget.animationController.status == AnimationStatus.forward) {
          shake3 = getForward(.2, .1,ac3);
          ac3.forward();
        } else if(widget.animationController.status == AnimationStatus.reverse){
          shake3 = getBackward(.2, .1,ac3);
          ac3.forward();
        }
      }
    });
  }

  changeToDay(bool _day) {
    day = _day;
    if (_day) {
      sunColor = Colors.amber[900];
      cloudColor = DAY_CLOUD_COLOR;
      treeG1Color = DAY_TREE_G_1;
      treeG2Color = Colors.green[800];
      backGroundG1 = DAY_BACKGROUND_G_1;
      backGroundG2 = DAY_BACKGROUND_G_1;
      smallRoofColor = DAY_SMALL_ROOF_COLOR;
      bigRoofColor = DAY_BIG_ROOF_COLOR;
      smallWallColor = DAY_BIG_WALL_COLOR;
      bigWallColor = DAY_BIG_WALL_COLOR;
      smokeG1Color = DAY_PIPE_G_1;
      smokeG2Color = DAY_PIPE_G_2;
      smokeTipColor = DAY_PIPE_TOP;
      earthColor = DAY_EARTH_COLOR;
      starColor = Colors.transparent;
      bigRoofBarColor = Colors.brown[300];
      switchOffWindowColor = Colors.brown[500];
      windowG1Color = Colors.brown[500];
      windowG2Color = Colors.brown[500];
      waterPipeColor = Colors.blueGrey;
      pipeGripColor = Colors.brown[200];
    } else {
      sunColor = Colors.grey[50];
      cloudColor = CLOUD_COLOR;
      treeG1Color = TREE_G_1;
      treeG2Color = TREE_G_2_COLOR;
      backGroundG1 = BACKGROUND_G_1;
      backGroundG2 = Colors.purple;
      smallRoofColor = SMALL_ROOF_COLOR;
      bigRoofColor = BIG_ROOF_COLOR;
      smallWallColor = SMALL_WALL_COLOR;
      bigWallColor = BIG_WALL_COLOR;
      smokeG1Color = PIPE_G_1;
      smokeG2Color = Colors.indigo[800];
      smokeTipColor = PIPE_TOP;
      earthColor = EARTH_COLOR;
      starColor = STAR_COLOR;
      bigRoofBarColor = Colors.blueGrey[600];
      switchOffWindowColor = Colors.indigo[800];
      windowG1Color = Colors.amber;
      windowG2Color = Colors.amber[800];
      waterPipeColor = Colors.blueGrey[800];
      pipeGripColor = Colors.blueGrey[600];
    }
  }

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
                      painter: IamTheBackgroundPainter(
                        g1: backGroundG2,
                        g2: backGroundG1,
                        starColor: starColor,
                      ),
                    ),
                    //cloud layer with sun/moon
                    Stack(
                      children: <Widget>[
                        //cloud with sun/moon
                        AnimatedBuilder(
                            animation: shake2,
                            builder: (context, snapshot) {
                              return Align(
                                //cloud alignment position
                                alignment: Alignment(
                                  shake2.value,
                                  -.16,
                                ),
                                child: Container(
                                  height: constraints.maxWidth * 0.1,
                                  width: constraints.maxWidth * 0.2,
                                  child: CustomPaint(
                                    foregroundPainter: IamTheCloudPainter(
                                        isSingle: false,
                                        cloudColor: cloudColor),
                                    painter: IamTheSunMoonPainter(
                                        sunColor: sunColor, isMoon: !day),
                                  ),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: shake3,
                            builder: (context, child) {
                              return Align(
                                //cloud alignment position
                                alignment: Alignment(
                                  shake3.value,
                                  -.7,
                                ),
                                child: Container(
                                  height: constraints.maxWidth * 0.08,
                                  width: constraints.maxWidth * 0.16,
                                  child: CustomPaint(
                                    foregroundPainter: IamTheCloudPainter(
                                        isSingle: false,
                                        cloudColor: cloudColor),
                                    //painter: IamTheSunMoonPainter(),
                                  ),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: shake1,
                            builder: (context, child) {
                              return Align(
                                //cloud alignment position
                                alignment: Alignment(
                                  shake1.value,
                                  -.15,
                                ),
                                child: Container(
                                  height: constraints.maxWidth * 0.04,
                                  width: constraints.maxWidth * 0.08,
                                  child: CustomPaint(
                                    foregroundPainter: IamTheCloudPainter(
                                        isSingle: true, cloudColor: cloudColor),
                                    //painter: IamTheSunMoonPainter(),
                                  ),
                                ),
                              );
                            }),
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
                              earthColor: earthColor,
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
                              painter: IamTheTreePainter(
                                  gradient1: treeG1Color,
                                  gradient2: treeG2Color,
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
                              painter: IamTheTreePainter(
                                  gradient1: treeG1Color,
                                  gradient2: treeG2Color,
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
                              painter: IamTheTreePainter(
                                  gradient1: treeG1Color,
                                  gradient2: treeG2Color,
                                  treeBark: Colors.blueGrey[800]),
                            ),
                          ),
                        ),
                        //tree
                        Align(
                          alignment: Alignment(1.3, .6),
                          child: Container(
                            //color: Colors.red,
                            width: constraints.maxWidth * .3,
                            height: constraints.maxHeight * .22,
                            child: CustomPaint(
                              painter: IamTheTreePainter(
                                  gradient1: treeG1Color,
                                  gradient2: treeG2Color,
                                  treeBark: Colors.blueGrey[800]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //small house
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(-.25, 1),
                          child: Container(
                            width: constraints.maxWidth * .35,
                            height: constraints.maxHeight * .3,
                            //color: Colors.white.withAlpha(50),
                            child: CustomPaint(
                              painter: IamTheBackHousePainter(
                                color1: smokeTipColor,
                                gradient1: smokeG1Color,
                                gradient2: smokeG2Color,
                                color4: smallRoofColor,
                                color5: smallWallColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //big house
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(.7, 1),
                          child: Container(
                            width: constraints.maxWidth * .37,
                            height: constraints.maxHeight * .48,
                            color: Colors.white.withAlpha(50),
                            child: CustomPaint(
                                painter: IamTheBigHousePainter(
                                    roofColor: bigRoofColor,
                                    roofBarColor: bigRoofBarColor,
                                    wallColor: bigWallColor,
                                    offWindow: switchOffWindowColor,
                                    pipeColor: waterPipeColor,
                                    pipeGripColor: pipeGripColor,
                                    linearGradient: LinearGradient(
                                      colors: [windowG1Color, windowG2Color],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ))),
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
