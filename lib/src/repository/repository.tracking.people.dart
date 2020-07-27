import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/repository/tracking.people.api.dart';

class RepositoryTrakingPeople {
  final trackingPeopleApi = TrackingPeopleAPI();

  Future<User> loginUserRepository(String user, String password) =>
      trackingPeopleApi.loginUser(user, password);
}
