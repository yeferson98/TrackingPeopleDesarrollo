import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/user/pages/widgets/time.pages.dart';

class PageBodyQR extends StatefulWidget {
  User user;
  PageBodyQR({Key key, @required this.user});
  @override
  _PageBodyQRState createState() => _PageBodyQRState();
}

class _PageBodyQRState extends State<PageBodyQR> {
  String codeQr = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            "Resultados de  Scanner Qr",
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
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/welcomeQr.jpeg'),
              ),
            ),
          ),
          Text(
            'Hola Mariela bienvenida a: ${codeQr.toString()}',
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(fontSize: 13)),
          )
        ],
      );
    }
  }

  scanQrCode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        codeQr = result;
      });
    } catch (e) {
      print(e);
    }
  }
}
