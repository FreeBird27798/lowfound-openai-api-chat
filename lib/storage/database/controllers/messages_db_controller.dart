import 'package:lowfound_openai_api_chat/model/message.dart';
import 'package:lowfound_openai_api_chat/storage/database/db_operations.dart';
import 'package:lowfound_openai_api_chat/storage/database/db_provider.dart';
import 'package:lowfound_openai_api_chat/storage/preferences/app_pref_controller.dart';
import 'package:sqflite/sqflite.dart';

class MessagesDbController extends DbOperations<Message> {
  Database _database;

  MessagesDbController() : _database = DBProvider().database;

  @override
  Future<int> create(Message message) {
    return _database.insert(Message.TABLE_NAME, message.toMap());
  }

  @override
  Future<List<Message>> read() async {
    List<Map<String, dynamic>> data = await _database.query(
      Message.TABLE_NAME,
      where: '${Message.USER_ID} = ?',
      whereArgs: [AppPrefController().user.id],
    );
    if (data.isNotEmpty) {
      return data
          .map((rowMap) => Message.fromMap(rowMap))
          .toList()
          .where((data) => data.userId == AppPrefController().user.id)
          .toList();
    }
    return [];
  }

  @override
  Future<bool> update(Message message) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) async {
    int deleteRowsCount = await _database.delete(Message.TABLE_NAME,
        where: '${Message.ID} = ?', whereArgs: [id]);
    return deleteRowsCount > 0;
  }

  @override
  Future<Message?> show(int id) {
    // TODO: implement show
    throw UnimplementedError();
  }
}
