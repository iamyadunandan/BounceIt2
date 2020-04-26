import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IamTheBackgroundPainter extends CustomPainter {
  RadialGradient _gradient = RadialGradient(
      colors: [
        Colors.purple,
        Colors.blue[800],
      ],
      radius: .9,
      stops: [0.35, 1]);
  Color starColor = Colors.amber;
  Random _random = Random();
  List<Offset> _stars = [];

  IamTheBackgroundPainter() {
    for (var i = 0; i < 32; i++) {
      _stars.add(Offset(_random.nextDouble(), _random.nextDouble()));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect gRect = Rect.fromLTWH(0, 0, size.width * 2, size.height * 2);

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    Paint paint = Paint()..shader = _gradient.createShader(gRect);
    canvas.drawRect(rect, paint);

    Paint paint2 = Paint()..color = starColor;
    for (var star in _stars) {
      Offset o = Offset(star.dx * size.width, star.dy * size.height);
      canvas.drawCircle(o, _random.nextDouble() * 3, paint2);
    }
  }

  @override
  bool shouldRepaint(IamTheBackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheBackgroundPainter oldDelegate) => false;
}

//The cloud painter

class IamTheCloudPainter extends CustomPainter {
  Color cloudColor, shadowColor;
  Random random = Random();
  bool isSingle;

  IamTheCloudPainter({@required this.isSingle, @required this.cloudColor}) {
    assert(cloudColor != null);
    shadowColor = Colors.black.withAlpha(140);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset cOffset =
        Offset(size.width / 2, size.height / 2 * random.nextDouble() * .5);
    if (isSingle) {
      canvas.drawCircle(cOffset, size.height / 2, Paint()..color = cloudColor);
    } else {
      Offset clOffset = Offset(
          size.width * 0.2, size.height * .65 * random.nextDouble() * .5);
      Offset crOffset =
          Offset(size.width * 0.8, size.height / 2 * random.nextDouble() * .5);
      Offset clnOffset =
          Offset(0, size.height * .65 * random.nextDouble() * .5);

      Paint shadowPaint = Paint()
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 16);
      Paint foregroundPaint = Paint()..color = cloudColor;

      Rect rightCircle =
          Rect.fromCircle(center: crOffset, radius: size.height / 3);
      Rect leftCircle =
          Rect.fromCircle(center: clOffset, radius: size.height / 3);
      Rect centerCircle =
          Rect.fromCircle(center: cOffset, radius: size.height / 2);
      Rect leftNextCircle =
          Rect.fromCircle(center: clnOffset, radius: size.height / 3.5);

      Path leftCenterPathClip = Path()
        ..addOval(leftCircle)
        ..addOval(centerCircle)
        ..addOval(rightCircle)
        ..addOval(leftNextCircle);
      Path leftCenterPathShadow = Path()
        ..addOval(leftCircle)
        ..addOval(centerCircle);

      //clip shadow;
      canvas.clipPath(
        leftCenterPathClip,
      );

      //left forground
      canvas.drawOval(leftNextCircle, foregroundPaint);
      //right foreground
      canvas.drawOval(rightCircle, foregroundPaint);
      //leftCenter shadow
      canvas.drawPath(leftCenterPathShadow, shadowPaint);
      //center foreground
      canvas.drawOval(centerCircle, foregroundPaint);
      //left foreground
      canvas.drawOval(leftCircle, foregroundPaint);
    }
  }

  @override
  bool shouldRepaint(IamTheCloudPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheCloudPainter oldDelegate) => false;
}

class IamTheSunMoonPainter extends CustomPainter {
  Color sunColor;
  bool isMoon;

  IamTheSunMoonPainter({@required this.sunColor, this.isMoon = false}) {
    assert(sunColor != null);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 3, -size.height / 1.5);
    double sunSize = size.width / 2.3;
    Offset offset2 = Offset(size.width / 1.3, -size.height);

    //clipped path
    Path clippedPath = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: offset, radius: sunSize)),
      Path()..addOval(Rect.fromCircle(center: offset2, radius: sunSize)),
    );
    if (isMoon)
      canvas.drawPath(clippedPath, Paint()..color = sunColor);
    else
      canvas.drawCircle(offset, sunSize, Paint()..color = sunColor);
  }

  @override
  bool shouldRepaint(IamTheSunMoonPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheSunMoonPainter oldDelegate) => false;
}

class IamTheEarthPainter extends CustomPainter {
  Color earthColor;

  IamTheEarthPainter({
    @required this.earthColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset earthCenter = Offset(size.width * 1, size.width * 1.6);
    double earthSize = size.width * 1.3;
    Rect earthRect = Rect.fromCircle(center: earthCenter, radius: earthSize);
    Rect clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawOval(earthRect, Paint()..color = earthColor);
  }

  @override
  bool shouldRepaint(IamTheEarthPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheEarthPainter oldDelegate) => false;
}

class IamTreeThePainter extends CustomPainter {
  Color gradient1, gradient2, treeBark;
  double height;
  double width;
  Offset offset;

  IamTreeThePainter({
    @required this.gradient1,
    @required this.gradient2,
    @required this.treeBark,
  }) {
    height = 1.6;
    width = 0.12;
  }

  @override
  void paint(Canvas canvas, Size size) {
    offset = Offset(size.width * .5, size.height * .32);
    //trees

    Rect logRect = Rect.fromLTWH(offset.dx - (size.width * width) / 2,
        offset.dy, size.width * width, size.height * height);

    Rect shadowRect = Rect.fromLTWH(
        offset.dx - (size.width * width) * 2,
        offset.dy + (size.height * height) - (size.width * width),
        size.width * width * 4,
        size.width * width * 2);
    canvas.drawOval(shadowRect, Paint()..color = gradient2.withAlpha(100));
    canvas.drawRect(logRect, Paint()..color = treeBark);

    Rect treeRect = Rect.fromCircle(center: offset, radius: size.width / 2);

    canvas.drawOval(
        treeRect,
        Paint()
          ..shader = LinearGradient(
                  colors: [gradient1, gradient2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              .createShader(treeRect));
  }

  drawTree(Offset offset, Canvas canvas, double maxHeight) {}

  @override
  bool shouldRepaint(IamTreeThePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTreeThePainter oldDelegate) => false;
}


class IamTheBackHousePainter extends CustomPainter {
  Color color1,gradient1,gradient2,color4,color5;

  IamTheBackHousePainter({@required this.color1,@required this.gradient1,@required this.gradient2,@required this.color4,@required this.color5}){

  }


  @override
  void paint(Canvas canvas, Size size) {
    double feet = size.width/12;
    double vFeet = size.height/18;

    Rect topR = Rect.fromLTWH(0,0,size.width,size.height);

    canvas.drawRect(topR, Paint()..color=Colors.greenAccent);
  }

  @override
  bool shouldRepaint(IamTheBackHousePainter oldDelegate) => false;


  @override
  bool shouldRebuildSemantics(IamTheBackHousePainter oldDelegate) => false;


}

