import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:segcov/src/models/people.model.dart';
import 'package:segcov/src/theme/theme.app.dart';

class ProfileUser extends StatefulWidget {
  PeopleModel people;
  ProfileUser({Key key, @required this.people});
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
            color: Theme.of(context).accentColor.withOpacity(1),
          ),
          title: Text(
            "Mi perfil",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.people.name + ' ' + widget.people.lastname,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      widget.people.email,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 55,
                height: 55,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.people.urlImage),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.15),
                  offset: Offset(0, 3),
                  blurRadius: 10)
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Nombre',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  widget.people.name,
                  style: TextStyle(color: Theme.of(context).focusColor),
                ),
              ),
              ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Apellido',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  widget.people.lastname,
                  style: TextStyle(color: Theme.of(context).focusColor),
                ),
              ),
              ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  widget.people.email,
                  style: TextStyle(color: Theme.of(context).focusColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.15),
                  offset: Offset(0, 3),
                  blurRadius: 10)
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Configuración',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              ListTile(
                onTap: () {},
                dense: true,
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.apps,
                      size: 22,
                      color: Theme.of(context).focusColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Tema de aplicación',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(width: 10),
                    Consumer<ThemeAplication>(
                      builder: (BuildContext context,
                          ThemeAplication themeAplication, Widget child) {
                        return Center(
                          child: Switch(
                            value: themeAplication.currentValueTheme,
                            onChanged: (value) {
                              if (value == true) {
                                themeAplication.addThemeHomen();
                              } else {
                                themeAplication.removeThemeHomen();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              /*ListTile(
                onTap: () {
                  // Navigator.of(context).pushNamed('/Help');
                },
                dense: true,
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.help,
                      size: 22,
                      color: Theme.of(context).focusColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Help & Support',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
