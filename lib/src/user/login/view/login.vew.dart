import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:segcov/src/bloc/tracking.people.bloc.dart';
import 'package:segcov/src/user/login/body/components/backgorund.dart';
import 'package:segcov/src/user/login/body/components/textField_container.dart';
import 'package:segcov/src/user/pages/view/dashboard.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userController, _passwordController;
  TrackingPeopleBloc trackingPeopleApp;
  String user = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    trackingPeopleApp = BlocProvider.of(context);
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: BackgorudApp(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * .4,
                    ),
                    Text(
                      'Ingrese sus credenciales',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _userController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => user = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'email',
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        validator: _validateEmail,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (value) => password = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'contraseña',
                          icon: Icon(
                            Icons.security,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        validator: _validatepassword,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Container(
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(
                            child: Text(
                          'Ingresar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: 17),
                        )),
                      ),
                      onTap: loginUser,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Campo vacio';
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    final nameExp = RegExp(p);
    if (!nameExp.hasMatch(value)) {
      return 'Email no valido';
    }
    return null;
  }

  String _validatepassword(String value) {
    if (value.isEmpty) {
      return 'Campo vacio';
    }
    return null;
  }

  loginUser() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      List<String> credential = [];
      credential.clear();
      credential.add(user);
      credential.add(password);
      trackingPeopleApp.loginUserBloc(credential[0], credential[1]).then(
        (response) async {
          if (response.status == null) {
            SharedPreferences _preferences =
                await SharedPreferences.getInstance();
            _preferences.setBool('isLoggedInUser', true);
            _preferences.setStringList('credentialUser', credential);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  child: DashboardView(user: response),
                  bloc: TrackingPeopleBloc(),
                ),
              ),
            );
          } else if (response.status == 404) {
            print('usuario no registrado');
          } else {
            print('ocurrio un error inesperado');
          }
        },
      );
    }
  }
}
