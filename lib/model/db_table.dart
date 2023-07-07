abstract class DbTable {
  DbTable();

  DbTable.fromMap(Map<String, dynamic> rowMap);

  Map<String, dynamic> toMap();
}
