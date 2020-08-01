import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:segcov/src/config/nitify.menu.dart';
import 'package:segcov/src/config/notify.widget.dart';
import 'package:segcov/src/models/people.model.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/user/pages/colors/backgorund.dashboard.dart';
import 'package:segcov/src/user/pages/view/pages/page.body.profile.dart';
import 'package:segcov/src/user/pages/view/pages/page.body.qr.dart';
import 'package:segcov/src/user/pages/widgets/phone/pinterest_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneView extends StatefulWidget {
  User user;
  PhoneView({Key key, @required this.user});
  @override
  _PhoneViewState createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  ScrollController controller = new ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > scrollAnterior && controller.offset > 150) {
        Provider.of<MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<MenuModel>(context, listen: false).mostrar = true;
      }

      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<MenuModel>(context).mostrar;
    return Column(
      children: <Widget>[
        Container(
          height: 100,
          width: double.infinity,
          child: BackgoundPanel(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.user.people[0].name,
                        style: Theme.of(context).textTheme.headline1.merge(
                              TextStyle(
                                  fontSize: 21,
                                  color: Theme.of(context).primaryColor),
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
                                'Cargo: ${widget.user.people[0].cargo}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .merge(TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              ListView(
                controller: controller,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Consumer<LayoutModel>(
                    builder:
                        (BuildContext context, LayoutModel page, Widget child) {
                      return page.currentPageView;
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  width: widthPantalla,
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      PinterestMenu(
                        mostrar: mostrar,
                        backgroundColor:
                            Theme.of(context).hintColor.withOpacity(0.5),
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: Theme.of(context).accentColor,
                        items: [
                          PinterestButton(
                              icon: Icons.home,
                              onPressed: () {
                                final layoutModel = Provider.of<LayoutModel>(
                                    context,
                                    listen: false);
                                layoutModel.currentPage = PageBodyQR(
                                  user: widget.user,
                                );
                              }),
                          PinterestButton(
                              icon: Icons.people,
                              onPressed: () {
                                final layoutModel = Provider.of<LayoutModel>(
                                    context,
                                    listen: false);
                                layoutModel.currentPage = ProfileUser(
                                  people: widget.user.people[0],
                                );
                              }),
                          /*PinterestButton(
                              icon: Icons.help,
                              onPressed: () {
                                print('Icon notifications');
                              }),*/
                          PinterestButton(
                              icon: Icons.exit_to_app,
                              onPressed: () {
                                alertInfo(widget.user.people[0]);
                              }),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void alertInfo(PeopleModel peopleModel) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return CupertinoAlertDialog(
          title: Text(
            peopleModel.name.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '¿Seguro que desea cerrar sesión?',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .merge(TextStyle(fontSize: 14)),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'SI',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: () async {
                SharedPreferences _preferences =
                    await SharedPreferences.getInstance();
                _preferences.remove('isLoggedInUser');
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
            CupertinoDialogAction(
              child: Text(
                'NO',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
