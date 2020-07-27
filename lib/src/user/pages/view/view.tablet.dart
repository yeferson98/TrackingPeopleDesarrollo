import 'package:flutter/material.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/user/pages/widgets/tablet/ListProfileUser.dart';
import 'package:segcov/src/user/pages/widgets/tablet/body.dart';

// ignore: must_be_immutable
class ViewTablet extends StatefulWidget {
  User user;
  ViewTablet({Key key, @required this.user});
  @override
  _ViewTabletState createState() => _ViewTabletState();
}

class _ViewTabletState extends State<ViewTablet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Container(
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          child: ListProfileUser(user: widget.user,),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: PainterheaderTablet(context: context),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 5),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * .2,
                    ),
                    Expanded(
                      child: BodyTablet(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PainterheaderTablet extends CustomPainter {
  final BuildContext context;
  PainterheaderTablet({this.context});
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
    path.lineTo(0, size.height * .2);
    path.quadraticBezierTo(
        size.width * .30, size.height * .10, size.width * .5, size.height * .2);
    path.quadraticBezierTo(
        size.width * .8, size.height * .35, size.width, size.height * .2);
    path.lineTo(size.width, 0);

    canva.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
