import 'package:hive/hive.dart';

import '../model/user_model.dart';

class AuthenticationService {
  //initialisasi box
  late Box<UserModel> _users;

  Future<void> init() async {
    //register hive
    Hive.registerAdapter(UserModelAdapter());
    _users = await Hive.openBox("usersBox");
    // _users.clear();
    // await _users.add(UserModel("testuser1", "password"));
    // await _users.add(UserModel("testuser2", "password"));
  }

  String authenticateUser(final String username, final String password) {
    print("usernmae service $username");
    final success = _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      print("username di service ${username.toString()}");
      return username;
    } else {
      return '';
    }
  }

  Future<UserCreationResult> createUser(
      final String username, final String password) async {
    final alreadyExist = _users.values.any(
        (element) => element.username.toLowerCase() == username.toLowerCase());
    if (alreadyExist) {
      return UserCreationResult.already_exist;
    }
    try {
      _users.add(UserModel(username, password));
      return UserCreationResult.success;
    } on Exception {
      return UserCreationResult.failure;
    }
  }
}

enum UserCreationResult { success, failure, already_exist }
