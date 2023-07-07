import 'package:lowfound_openai_api_chat/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefController {
  final String isLoggedInKey = 'isLoggedIn';

  static final AppPrefController _instance = AppPrefController._internal();
  late SharedPreferences _sharedPreferences;

  AppPrefController._internal();

  factory AppPrefController() {
    return _instance;
  }

  Future<void> initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get pref => _sharedPreferences;

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  //USER
  Future<void> saveUser({required User user}) async {
    await _sharedPreferences.setInt(User.ID, user.id);
    await _sharedPreferences.setString(User.USER_NAME, user.username);
    await _sharedPreferences.setString(User.PASSWORD, user.password);
    await _sharedPreferences.setBool(isLoggedInKey, true);
  }

  User get user {
    User user = User();
    user.id = _sharedPreferences.getInt(User.ID) ?? 0;
    user.username = _sharedPreferences.getString(User.USER_NAME) ?? '';
    user.password = _sharedPreferences.getString(User.PASSWORD) ?? '';
    return user;
  }

  bool get loggedIn => _sharedPreferences.getBool(isLoggedInKey) ?? false;

  Future<bool> logout() async {
    return await clear();
  }
}
