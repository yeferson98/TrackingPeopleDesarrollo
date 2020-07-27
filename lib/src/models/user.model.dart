import 'package:segcov/src/models/people.model.dart';

class User {
  String token;
  PeopleModel people;
  int status;
  User({this.token, this.people, this.status});
  factory User.fromJson(Map<String, dynamic> parseJson) {
    var people = parseJson['user'];
    return User(
        token: parseJson['token'], people: PeopleModel.formJson(people));
  }
}
