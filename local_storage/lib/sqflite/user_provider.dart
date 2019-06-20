import 'sqflite_provider.dart';
import 'user.dart';

class UserProvider {
  final DatabaseProvider provider;

  UserProvider(this.provider);

  Future<User> insertUser(User user) async {
    user.id =
        await provider.db.then((db) => db.insert(tableName, user.toJson()));
    return user;
  }

  Future<User> getUser(int id) async {
    List<Map> maps = await provider.db.then((db) => db.query(tableName,
        columns: [columnId, columnEmail, columnName],
        where: '$columnId = ?',
        whereArgs: [id]));

    if (maps.length > 0) {
      return User.fromJsonMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getUserList() async {
    return provider.db
        .then((db) =>
            db.query(tableName, columns: [columnId, columnEmail, columnName]))
        .then((res) => res.map((c) => User.fromJsonMap(c)).toList());
  }

  Future<int> deleteUser(int id) async {
    print(id);
    var res =  provider.db.then(
        (db) => db.delete(tableName, where: '$columnId = ?', whereArgs: [id]));
    return res;
  }

  Future<int> updateUser(User user) async {
    return provider.db.then((db) => db.update(tableName, user.toJson(),
        where: '$columnId = ?', whereArgs: [user.id]));
  }
}
