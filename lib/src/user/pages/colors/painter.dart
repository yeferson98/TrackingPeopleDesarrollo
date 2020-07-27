import 'package:flutter/material.dart';

class BodyDashboarPainter extends CustomPainter {
  final BuildContext context;
  BodyDashboarPainter({this.context});
  @override
  void paint(Canvas canva, Size size) {
    final lapiz = new Paint();
    final path = new Path();

    //propierties
    lapiz.color = Theme.of(context).accentColor;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    //area de dibujo
    /*path.quadraticBezierTo(size.width * .30, size.height * .35, size.width * .5,
        size.height * .30);*/
    /*path.quadraticBezierTo(
        size.width * .70, size.height * .25, size.width, size.height * .30);*/
    path.lineTo(0, size.height * .7);
    path.quadraticBezierTo(
        size.width * .3, size.height, size.width * .5, size.height * .7);
    path.quadraticBezierTo(
        size.width * .8, size.height * .30, size.width, size.height * .7);
    path.lineTo(size.width, 0);

    canva.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
