import 'package:segcov/src/models/people.model.dart';

class User {
  String token;
  List<PeopleModel> people;
  int status;
  User({this.token, this.people, this.status});
  factory User.fromJson(Map<String, dynamic> parseJson) {
    var people = parseJson['user'] as List;
    List<PeopleModel> mapList =
        people.map((i) => PeopleModel.formJson(i)).toList();
    return User(token: parseJson['token'], people: mapList);
  }
}
