import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:segcov/src/config/notify.widget.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/user/pages/view/pages/page.body.profile.dart';
import 'package:segcov/src/user/pages/view/pages/page.body.qr.dart';

class ListProfileUser extends StatelessWidget {
  ListProfileUser({@required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 100,
      child: CustomPaint(
        painter: PainterProfileUser(context: context),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.people.name,
                style: Theme.of(context).textTheme.headline1.merge(
                      TextStyle(
                          fontSize: 21, color: Theme.of(context).primaryColor),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Cargo: Adminstradora',
                        style: Theme.of(context).textTheme.headline1.merge(
                            TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * .1),
              Expanded(
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          final layoutModel =
                              Provider.of<LayoutModel>(context, listen: false);
                          layoutModel.currentPage = PageBodyQR(
                            user: user,
                          );
                        },
                        leading: Icon(
                          Icons.home,
                          color: Theme.of(context).focusColor.withOpacity(1),
                        ),
                        title: Text(
                          "Inicio",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          final layoutModel =
                              Provider.of<LayoutModel>(context, listen: false);
                          layoutModel.currentPage = ProfileUser();
                        },
                        leading: Icon(
                          Icons.people,
                          color: Theme.of(context).focusColor.withOpacity(1),
                        ),
                        title: Text(
                          "Perfil",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Configuración",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Icon(
                          Icons.remove,
                          color: Theme.of(context).focusColor.withOpacity(0.3),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          //Navigator.of(context).pushNamed('/Tabs', arguments: 0);
                        },
                        leading: Icon(
                          Icons.help,
                          color: Theme.of(context).focusColor.withOpacity(1),
                        ),
                        title: Text(
                          "Ayuda",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          //Navigator.of(context).pushNamed('/Login');
                        },
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).focusColor.withOpacity(1),
                        ),
                        title: Text(
                          "Log out",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Versión 0.0.1",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Icon(
                          Icons.remove,
                          color: Theme.of(context).focusColor.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PainterProfileUser extends CustomPainter {
  final BuildContext context;
  PainterProfileUser({this.context});
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
        size.width * .3, size.height * .4, size.width, size.height * .2);
    path.lineTo(size.width, 0);

    canva.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
