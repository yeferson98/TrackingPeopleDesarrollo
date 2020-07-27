import 'dart:io';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'dart:async';

import 'package:segcov/src/bloc/tracking.people.bloc.dart';
import 'package:segcov/src/user/login/view/login.vew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/user/pages/view/dashboard.view.dart';

// ignore: must_be_immutable
class SplashTrackingPeople extends StatefulWidget {
  bool isLoggedIn;
  SplashTrackingPeople({Key key, this.isLoggedIn}) : super(key: key);
  @override
  _SplashTrackingPeopleState createState() => _SplashTrackingPeopleState();
}

class _SplashTrackingPeopleState extends State<SplashTrackingPeople> {
  TrackingPeopleBloc trackingPeopleApp;
  bool isconection = true;
  bool isreconnecting = true;
  String messageStatus = "";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _homeAtuhUserKushi(widget.isLoggedIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    trackingPeopleApp = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: isconection ? _logo() : reconectando()),
    );
  }

  Widget _logo() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 100,
              child: Image(
                image: AssetImage('assets/gifconnection.gif'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              messageStatus,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .merge(TextStyle(color: Colors.orangeAccent)),
            ),
          ],
        ),
      ),
    );
  }

  void _homeAtuhUserKushi(bool status) async {
    try {
      setState(() {
        messageStatus = "Iniciando Tracking People...";
      });
      if (status) {
        SharedPreferences _preferences = await SharedPreferences.getInstance();
        final objetUser = _preferences.getStringList('credentialUser');
        trackingPeopleApp.loginUserBloc(objetUser[0], objetUser[1]).then(
          (response) async {
            if (response.status == null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider(
                    child: DashboardView(user: response),
                    bloc: TrackingPeopleBloc(),
                  ),
                ),
              );
            } else if (response.status == 404) {
              setState(() => isreconnecting = true);
              setState(() => isconection = false);
            } else {
              setState(() => isreconnecting = true);
              setState(() => isconection = false);
            }
          },
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              child: LoginView(),
              bloc: TrackingPeopleBloc(),
            ),
          ),
        );
      }
    } on SocketException {
      setState(() => isreconnecting = true);
      setState(() => isconection = false);
      print('Error  de conexiion');
    }
  }

  Widget reconectando() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isreconnecting
                ? Container(
                    width: 100,
                    child: Image(
                      image: AssetImage('assets/noConnection.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 100,
                    height: 150,
                    child: Image(
                      image: AssetImage('assets/gifconnection.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(
              height: 6,
            ),
            Flexible(
              child: Text('Ocurrio un error, no pude comunicarme con internet'),
            ),
            SizedBox(
              height: 20,
            ),
            isreconnecting
                ? SizedBox(
                    width: 320,
                    child: FlatButton(
                      onPressed: () {
                        setState(() => isreconnecting = false);
                        _homeAtuhUserKushi(widget.isLoggedIn);
                      },
                      padding: EdgeInsets.symmetric(vertical: 14),
                      color: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Reintentar',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
