import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:segcov/src/bloc/tracking.people.bloc.dart';
import 'package:segcov/src/config/nitify.menu.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/user/pages/widgets/time.pages.dart';

class PageBodyQR extends StatefulWidget {
  User user;
  PageBodyQR({Key key, @required this.user});
  @override
  _PageBodyQRState createState() => _PageBodyQRState();
}

class _PageBodyQRState extends State<PageBodyQR>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorTween;
  var countStream = Stream<double>.periodic(
      Duration(milliseconds: 100), (x) => (x / 100).toDouble()).take(101);
  String codeQr = "";
  String messageSave = "", messageSave2 = "";
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1800), vsync: this);
    _colorTween = _animationController
        .drive(ColorTween(begin: Colors.green, end: Colors.red));
    _animationController.repeat();
    super.initState();
  }

  TrackingPeopleBloc trackingPeopleApp;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    trackingPeopleApp = BlocProvider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TimeAndDate(),
        SizedBox(
          height: 11,
        ),
        ListTile(
          onTap: () => scanQrCode(),
          leading: Icon(
            Icons.phone_android,
            color: Theme.of(context).focusColor.withOpacity(1),
          ),
          title: Text(
            "Scanea tu codigo QR",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/codeQR.png'))),
          ),
          onTap: () => scanQrCode(),
        ),
        SizedBox(
          height: 25,
        ),
        ListTile(
          onTap: () {
            //Navigator.of(context).pushNamed('/Help');
          },
          leading: Icon(
            Icons.save,
            color: Theme.of(context).focusColor.withOpacity(1),
          ),
          title: Text(
            "Resultados de  Scanner QR",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        valueCodeQr()
      ],
    );
  }

  Widget valueCodeQr() {
    if (codeQr == "" || codeQr == " ") {
      return Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/empydata.jpeg'),
              ),
            ),
          ),
          Text(
            messageSave2,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .merge(TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.accessibility_new,
            size: 50,
            color: Theme.of(context).accentColor,
          ),
          Column(
            children: <Widget>[
              Text(
                'Hola ${widget.user.people[0].name}, Bienvenido(a)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'al área de:',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                '${codeQr.toString()}',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                backgroundColor: Theme.of(context).hintColor.withOpacity(0.10),
                valueColor: _colorTween,
              ),
            ),
          ),
          Text(
            messageSave,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }
  }

  scanQrCode() async {
    try {
      final result = await BarcodeScanner.scan();
      if (result != "") {
        final data = result.split(',');
        if (data.length > 1 && data[2] == "Q98Y") {
          setState(() {
            codeQr = data[1].toString();
            messageSave = "Comunicandose con el servidor...";
          });
          Provider.of<MenuModel>(context, listen: false).mostrar = false;
          Future<void>.delayed(const Duration(seconds: 5))
            ..then<void>((_) {
              if (mounted) {
                saveArea(data[0]);
              }
            });
        } else {
          setState(() {
            codeQr = '';
            messageSave2 = "No puedo escannear este tipo de patrones  ";
          });
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        codeQr = '';
        messageSave2 = "";
      });
    }
  }

  void saveArea(String codearea) {
    final date = DateTime.now();
    final fecha = formatDate(date, [yyyy, '-', mm, '-', dd]);
    final hora = formatDate(date, [hh, ':', nn, ':', ss]);
    String newDate = fecha + ' ' + hora;
    setState(() {
      messageSave = "Guardando ubicación";
    });
    trackingPeopleApp
        .saveAreaRepository(newDate, widget.user.token, codearea)
        .then(
      (status) {
        if (status == 200) {
          setState(() {
            codeQr = "";
            messageSave = "";
            messageSave2 = "${widget.user.people[0].name}, ya puede continuar";
          });
          Provider.of<MenuModel>(context, listen: false).mostrar = true;
        } else {
          setState(() {
            codeQr = "";
            messageSave = "";
            messageSave2 =
                "${widget.user.people[0].name}, alto scanne el codigo nuevamente";
          });
          Provider.of<MenuModel>(context, listen: false).mostrar = true;
        }
      },
    );
  }
}
