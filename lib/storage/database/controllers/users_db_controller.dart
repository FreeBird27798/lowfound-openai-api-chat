import 'package:lowfound_openai_api_chat/model/user.dart';
import 'package:lowfound_openai_api_chat/storage/database/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class UsersDbController {
  Database _database;

  UsersDbController() : _database = DBProvider().database;

  Future<int> createAccount({required User user}) async {
    return await _database.insert(User.TABLE_NAME, user.toMap());
  }

  Future<User?> login(
      {required String username, required String password}) async {
    var data = await _database.query(User.TABLE_NAME,
        where: '${User.USER_NAME} = ? AND ${User.PASSWORD} = ?',
        whereArgs: [username, password]);
    return data.isNotEmpty ? User.fromMap(data.first) : null;
  }
}
