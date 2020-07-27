import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:segcov/src/models/user.model.dart';
import 'package:segcov/src/repository/repository.tracking.people.dart';

class TrackingPeopleBloc implements Bloc {
  final _getRepositoryApp = RepositoryTrakingPeople();
  Future<User> loginUserBloc(String user, String password) =>
      _getRepositoryApp.loginUserRepository(user, password);
  @override
  void dispose() {}
}
