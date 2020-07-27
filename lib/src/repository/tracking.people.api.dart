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
}
