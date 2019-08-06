import 'package:local_storage/sqflite/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDB {
  static final SembastDB _sembast = new SembastDB._();
  SembastDB._();

  factory SembastDB() {
    return _sembast;
  }

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return _openDB();
    }
    return _database;
  }

  Future<Database> _openDB() async {
// get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
// make sure it exists
    await dir.create(recursive: true);
// build the database path
    var dbPath = join(dir.path, 'sembast_db.db');
// open the database
    var db = await databaseFactoryIo.openDatabase(dbPath);
    return db;
  }
}

class UserDao {
  static const String USER_STORE_NAME = "users";

  var _store = intMapStoreFactory.store(USER_STORE_NAME);

  Future<Database> get _db async => SembastDB._sembast.database;

  Future insert(User user) async {
    await _store.add(await _db, user.toJson());
  }

  Future delete(User user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _store.delete(
      await _db,
      finder: finder,
    );
  }

  Future update(User user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _store.update(
      await _db,
      user.toJson(),
      finder: finder,
    );
  }

  Future<List<User>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _store.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final user = User.fromJsonMap(snapshot.value);
      user.id = snapshot.key;
      return user;
    }).toList();
  }
}
