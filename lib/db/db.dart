//DB interface
import '../models/data_models.dart';

class DbInterface {
  Future initDB() {
    return Future<dynamic>.value(null);
  }

  Future<List<Map<String, dynamic>>> select(String table,
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) {
    return Future.value(null);
  }

  Future<int> insert(String table, DataModel model) {
    return Future.value(null);
  }

  Future<int> update(String table, DataModel model) {
    return Future.value(null);
  }

  Future<int> delete(String table, DataModel model) {
    return Future.value(null);
  }
}
