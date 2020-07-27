import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:segcov/src/config/notify.widget.dart';

class BodyTablet extends StatefulWidget {
  @override
  _BodyTabletState createState() => _BodyTabletState();
}

class _BodyTabletState extends State<BodyTablet> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Consumer<LayoutModel>(
          builder: (BuildContext context, LayoutModel page, Widget child) {
            return page.currentPageView;
          },
        ),
      ],
    );
  }
}
