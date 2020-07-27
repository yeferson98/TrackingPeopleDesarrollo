import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            //Navigator.of(context).pushNamed('/Help');
          },
          leading: Icon(
            Icons.people,
            color: Theme.of(context).focusColor.withOpacity(1),
          ),
          title: Text(
            "Perfil de usuario",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}
