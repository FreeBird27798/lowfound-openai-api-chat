import 'db_table.dart';

class Message extends DbTable {
  late int id;
  late int userId;
  late String message;
  late String response;
  late DateTime createdAt;

  static const TABLE_NAME = 'messages';

  static const ID = 'id';
  static const USER_ID = 'user_id';
  static const MESSAGE = 'message';
  static const RESPONSE = 'response';
  static const CREATED_AT = 'created_at';

  Message();

  Message.fromMap(Map<String, dynamic> rowMap) : super.fromMap(rowMap) {
    this.id = rowMap[ID];
    this.userId = rowMap[USER_ID];
    this.message = rowMap[MESSAGE];
    this.response = rowMap[RESPONSE];
    createdAt = DateTime.parse(rowMap[CREATED_AT]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data[USER_ID] = this.userId;
    data[MESSAGE] = this.message;
    data[RESPONSE] = this.response;
    data[CREATED_AT] = createdAt.toIso8601String();
    return data;
  }
}
