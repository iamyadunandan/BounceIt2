import 'dart:math';
import 'dart:ui';
import 'dart:developer' as Log;

import 'package:daynight/IamTheDrawing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IamTheBackgroundPainter extends CustomPainter {
  Color g1, g2, starColor;
  IamTheBackgroundPainter(
      {@required this.g1, @required g2, @required this.starColor}) {
    _gradient = RadialGradient(
        colors: [
          g1,
          g2,
        ],
        radius: .9,
        stops: [0.35, 1]);

    for (var i = 0; i < 32; i++) {
      _stars.add(Offset(_random.nextDouble(), _random.nextDouble()));
    }
  }
  RadialGradient _gradient;
  Random _random = Random();
  List<Offset> _stars = [];

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
  //Random random = Random();
  bool isSingle;

  IamTheCloudPainter({@required this.isSingle, @required this.cloudColor}) {
    assert(cloudColor != null);
    shadowColor = Colors.black.withAlpha(140);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset cOffset = Offset(size.width / 2, size.height / 2);
    if (isSingle) {
      canvas.drawCircle(cOffset, size.height / 2, Paint()..color = cloudColor);
    } else {
      Offset clOffset = Offset(size.width * 0.2, size.height * .65);
      Offset crOffset = Offset(size.width * 0.8, size.height / 2);
      Offset clnOffset = Offset(0, size.height * .65);

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

class IamTheTreePainter extends CustomPainter {
  Color gradient1, gradient2, treeBark;
  double height;
  double width;
  Offset offset;

  IamTheTreePainter({
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
  bool shouldRepaint(IamTheTreePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheTreePainter oldDelegate) => false;
}

class IamTheBackHousePainter extends CustomPainter {
  Color color1, gradient1, gradient2, color4, color5;

  IamTheBackHousePainter(
      {@required this.color1,
      @required this.gradient1,
      @required this.gradient2,
      @required this.color4,
      @required this.color5});

  @override
  void paint(Canvas canvas, Size size) {
    double feet = size.width / 4;
    double vFeet = size.height / 9;
    Offset center = Offset(size.width / 2, size.height / 2);

    Rect topR = Rect.fromLTWH(center.dx - feet / 2, 0, feet, vFeet);
    var leftPoint = Offset(center.dx - feet / 2, 0 + vFeet / 2);
    var rightPoint = Offset(center.dx + feet / 2, 0 + vFeet / 2);
    Rect side1 = Rect.fromCircle(center: leftPoint, radius: vFeet / 2);
    Rect side2 = Rect.fromCircle(center: rightPoint, radius: vFeet / 2);
    Path p = Path()
      ..addRect(topR)
      ..addOval(side1)
      ..addOval(side2);

    //pipe below ring
    Rect pipeR = Rect.fromLTRB(
        leftPoint.dx, leftPoint.dy, rightPoint.dx, rightPoint.dy + vFeet * 2);
    canvas.drawRect(
      pipeR,
      Paint()
        ..shader = LinearGradient(
          colors: [gradient1, gradient2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(pipeR),
    );

    //top ring
    canvas.drawPath(p, Paint()..color = color1);

    //roof
    Offset rTL = Offset(vFeet * 1.5, (vFeet / 2) + vFeet * 2),
        rBL = Offset(0, rTL.dy + vFeet * 3.7),
        rBR = Offset(size.width, rBL.dy),
        rTR = Offset(rBR.dx, rTL.dy);

    Path rPath = Path()..addPolygon([rTL, rBL, rBR, rTR], true);

    canvas.drawPath(rPath, Paint()..color = color4);

    Offset wTL = Offset(rTL.dx, rBL.dy),
        wBL = Offset(rTL.dx, rTL.dy + (vFeet * 10)),
        wBR = Offset(rTR.dx, size.height);

    Rect wR = Rect.fromLTRB(wTL.dx, wTL.dy, wBR.dx, wBR.dy);

    canvas.drawRect(wR, Paint()..color = color5);
  }

  @override
  bool shouldRepaint(IamTheBackHousePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheBackHousePainter oldDelegate) => false;
}

class IamTheBigHousePainter extends CustomPainter {
  Color roofColor, roofBarColor, wallColor, offWindow, pipeColor, pipeGripColor;
  LinearGradient linearGradient;

  IamTheBigHousePainter(
      {@required this.roofColor,
      @required this.roofBarColor,
      @required this.linearGradient,
      @required this.wallColor,
      @required this.offWindow,
      @required this.pipeColor,
      @required this.pipeGripColor}) {
    assert(linearGradient != null);
    assert(offWindow != null);
    assert(pipeColor != null);
    assert(pipeGripColor != null);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var feet = size.width / 8;

    //wall
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height),
        Paint()..color = wallColor);

    Path p = Path()
      ..moveTo(0, 0)
      ..arcToPoint(
        Offset(-feet * 1.6, size.height * .4),
        radius: Radius.elliptical(feet * 3.2, feet * 3.2),
      )
      ..lineTo(size.width + (feet * 1.6), size.height * .4)
      ..arcToPoint(
        Offset(size.width, 0),
        radius: Radius.elliptical(feet * 3.2, feet * 3.2),
      )
      ..close();

    canvas.drawPath(
        p,
        Paint()
          ..color = roofColor
          ..style = PaintingStyle.fill);

    Path pp = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(
        pp,
        Paint()
          ..strokeWidth = feet / 3
          ..style = PaintingStyle.stroke
          ..color = roofBarColor);

    Path pipe1 = Path()
      ..moveTo(-feet * .5, size.height)
      ..lineTo(-feet * .5, size.height * .55)
      ..arcToPoint(Offset(-feet * 1.3, size.height * .43),
          radius: Radius.elliptical(feet, feet));

    Path pipe2 = Path()
      ..moveTo(size.width + feet * .5, size.height)
      ..lineTo(size.width + feet * .5, size.height * .55)
      ..arcToPoint(
        Offset(size.width + feet * 1.3, size.height * .43),
        radius: Radius.elliptical(feet, feet),
        clockwise: false,
      );

    canvas.drawPath(
        pipe1,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeColor
          ..strokeWidth = feet / 3);

    canvas.drawPath(
        pipe2,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeColor
          ..strokeWidth = feet / 3);
    //left tip
    canvas.drawLine(
        Offset(-feet * 1.8, size.height * .43),
        Offset(-feet * .9, size.height * .43),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = roofColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);
    //right tip
    canvas.drawLine(
        Offset(size.width + feet * 1.8, size.height * .43),
        Offset(size.width + feet * .9, size.height * .43),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = roofColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);
    //right grip 1
    canvas.drawLine(
        Offset(size.width, size.height * .56),
        Offset(size.width + feet * .7, size.height * .56),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeGripColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);
    //right grip 2
    canvas.drawLine(
        Offset(size.width, size.height * .72),
        Offset(size.width + feet * .7, size.height * .72),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeGripColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);
    //right grip 3
    canvas.drawLine(
        Offset(size.width, size.height * .88),
        Offset(size.width + feet * .7, size.height * .88),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeGripColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);

    //left grip 1
    canvas.drawLine(
        Offset(0, size.height * .56),
        Offset(-feet * .7, size.height * .56),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeGripColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);

    //left grip 2
    canvas.drawLine(
        Offset(0, size.height * .72),
        Offset(-feet * .7, size.height * .72),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeGripColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);

    //left grip 3
    canvas.drawLine(
        Offset(0, size.height * .88),
        Offset(-feet * .7, size.height * .88),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = pipeGripColor
          ..strokeWidth = feet / 4
          ..strokeCap = StrokeCap.round);

    draw(canvas, size, feet * 1.2, 0, feet * .3, feet * .6, 0.9, roofColor,
        linearGradient);
    draw(canvas, size, feet, -feet * 1.6, feet * 3, 0.6, 1.4, wallColor,
        linearGradient);
    draw(canvas, size, feet, 0, feet * 3, 0.6, 1.4, wallColor, linearGradient);
    draw(canvas, size, feet, feet * 1.6, feet * 3, 0.6, 1.4, wallColor, null);
  }

  draw(Canvas canvas, Size size, double feet, double x, double y, double w,
      double h, Color color, LinearGradient linearG) {
    if (linearG == null) {
      linearG = LinearGradient(colors: [offWindow, offWindow]);
    }
    Path ppp = Path()
      ..moveTo(x + (size.width * .5) - (w / 2) - (feet / 2), y + feet * 2 * h)
      ..lineTo(w / 2 + x + (size.width * 0.5) + (feet / 2), y + feet * 2 * h)
      ..lineTo(w / 2 + x + (size.width * 0.5) + (feet / 2), y + feet)
      ..arcToPoint(
          Offset(x + (size.width * .5) - (w / 2) - (feet / 2), y + feet),
          radius: Radius.circular(8),
          clockwise: false
          //rotation: pi/2,
          );

    canvas.drawPath(
        ppp, Paint()..shader = linearG.createShader(ppp.getBounds()));

    canvas.drawLine(
      Offset(x + (size.width * .5) - (w / 2) - (feet / 2), y + feet),
      Offset(w / 2 + x + (size.width * 0.5) + (feet / 2), y + feet),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = feet / 4
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(IamTheBigHousePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(IamTheBigHousePainter oldDelegate) => false;
}
