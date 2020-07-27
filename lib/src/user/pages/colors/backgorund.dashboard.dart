import 'package:flutter/material.dart';
import 'package:segcov/src/user/pages/colors/painter.dart';

class BackgoundPanel extends StatelessWidget {
  final Widget child;
  BackgoundPanel({this.child});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BodyDashboarPainter(context: context),
      child: child,
    );
  }
}
