import 'package:lowfound_openai_api_chat/model/message.dart';
import 'package:lowfound_openai_api_chat/model/user.dart';
import 'package:sqflite/sqflite.dart';

mixin Queries {
  late Database dbInstance;

  Future<void> createUsersTable() async {
    await dbInstance.execute('CREATE TABLE ${User.TABLE_NAME} ('
        '${User.ID} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${User.USER_NAME} TEXT,'
        '${User.PASSWORD} TEXT'
        ')');
  }

  Future<void> createMessagesTable() async {
    await dbInstance.execute('CREATE TABLE ${Message.TABLE_NAME} ('
        '${Message.ID} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${Message.USER_ID} INTEGER,'
        '${Message.MESSAGE} TEXT,'
        '${Message.RESPONSE} TEXT,'
        '${Message.CREATED_AT} DATE'
        ')');
  }
}
