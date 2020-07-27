import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:segcov/src/bloc/tracking.people.bloc.dart';
import 'package:segcov/src/config/nitify.menu.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/user/pages/view/view.phone.dart';
import 'package:segcov/src/user/pages/view/view.tablet.dart';

class DashboardView extends StatefulWidget {
  User user;
  DashboardView({Key key, @required this.user});
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  TrackingPeopleBloc trackingPeopleApp;
  @override
  Widget build(BuildContext context) {
    trackingPeopleApp = BlocProvider.of(context);
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => new MenuModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Scanner Qr ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1.merge(
                  TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
          ),
          elevation: 0,
          actions: <Widget>[
            Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {
                    //Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.people.urlImage),
                  ),
                )),
          ],
        ),
        body: valueContentAplication(),
      ),
    );
  }

  Widget valueContentAplication() {
    final size = MediaQuery.of(context).size;
    if (size.width > 500) {
      return ViewTablet(
        user: widget.user,
      );
    } else {
      return PhoneView(
        user: widget.user,
      );
    }
  }
}
