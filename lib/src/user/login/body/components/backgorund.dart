import 'package:flutter/material.dart';
import 'package:segcov/src/user/login/body/colors/pointer.colors.dart';

class BackgorudApp extends StatelessWidget {
  final Widget child;
  BackgorudApp({this.child});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BodyAppPainter(context: context),
      child: child,
    );
  }
}
