import 'db_table.dart';

class User extends DbTable {
  late int id;
  late String username;
  late String password;

  static const TABLE_NAME = 'users';
  static const ID = 'id';
  static const USER_NAME = 'username';
  static const PASSWORD = 'password';

  User();

  User.fromMap(Map<String, dynamic> rowMap) : super.fromMap(rowMap) {
    id = rowMap[ID];
    username = rowMap[USER_NAME];
    password = rowMap[PASSWORD];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map[USER_NAME] = username;
    map[PASSWORD] = password;
    return map;
  }
}
