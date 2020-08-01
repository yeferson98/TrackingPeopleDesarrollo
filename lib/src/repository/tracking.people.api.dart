import 'dart:convert';

import 'package:segcov/src/constants/tracking.people.constants.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:http/http.dart' as http;

class TrackingPeopleAPI {
  Future<User> loginUser(String user, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['usuario'] = user;
      map['password'] = password;

      final response = await http.post(CONSTANTSROUTE.LOGINUSER, body: map);
      if (response.statusCode == 200) {
        return parseUser(response.body);
      } else {
        return User(status: 404);
      }
    } catch (e) {
      return User(status: 500);
    }
  }

  static User parseUser(String responseBody) {
    final map = jsonDecode(responseBody) as Map<String, dynamic>;
    return User.fromJson(map);
  }

  Future<int> saveArea(String fecha, token, codArea) async {
    try {
      Map<String, String> headers = {
        "Authorization": "bearer" + token,
      };
      var map = Map<String, dynamic>();
      map['fecha'] = fecha;
      map['cod_area'] = codArea;
      var response = await http.post(CONSTANTSROUTE.REGISTERAREA,
          body: map, headers: headers);
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 401) {
        return 401;
      } else if (response.statusCode == 500) {
        return 500;
      } else {
        return 403;
      }
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
