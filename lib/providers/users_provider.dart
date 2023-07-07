import 'package:flutter/material.dart';
import 'package:lowfound_openai_api_chat/model/user.dart';
import 'package:lowfound_openai_api_chat/storage/database/controllers/users_db_controller.dart';
import 'package:lowfound_openai_api_chat/storage/preferences/app_pref_controller.dart';
import 'package:provider/provider.dart';

class UsersProvider extends ChangeNotifier {
  UsersDbController _userDbController = UsersDbController();
  late User user;

  static UsersProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<UsersProvider>(context, listen: listen);

  UsersProvider() {
    if (AppPrefController().loggedIn) user = AppPrefController().user;
  }

  Future<bool> createAccount({required User user}) async {
    var newUserId = await _userDbController.createAccount(user: user);
    if (newUserId != 0) {
      user.id = newUserId;
      await AppPrefController().saveUser(user: user);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login(
      {required String username, required String password}) async {
    User? user =
        await _userDbController.login(username: username, password: password);
    if (user != null) {
      await AppPrefController().saveUser(user: user);
      this.user = user;
      notifyListeners();
      return true;
    }
    return false;
  }
}
