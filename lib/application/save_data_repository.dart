import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xref/application/save_data.dart';

abstract class SaveDataRepository {
  Future<Iterable<SaveData>> findAll();

  Future<SaveData> findOf(int index);

  Future save(SaveData saveData);

  Future delete(SaveData saveData);
}

class DatabaseProvider {
  Future<Database> get database async {
    final path = join(await getDatabasesPath(), "database.db");
    return _database ??= await openDatabase(path);
  }

  Database? _database;

  Future<String> getDbPath() async {
    if (Platform.isMacOS || Platform.isMacOS) {
      return await getLibraryDirectory().toString();
    }

    if (Platform.isWindows || Platform.isLinux) {
      return await getApplicationSupportDirectory().toString();
    }

    return await getDatabasesPath();
  }
}

class SqliteSaveDataRepository implements SaveDataRepository {
  const SqliteSaveDataRepository(this.provider);

  final DatabaseProvider provider;

  @override
  Future delete(SaveData saveData) async {
    final db = await provider.database;
    db.delete("save_data", where: "id=?");
  }

  @override
  Future<Iterable<SaveData>> findAll() async {
    // TODO: implement findOf
    throw UnimplementedError();
  }

  @override
  Future<SaveData> findOf(int index) async {
    // TODO: implement findOf
    throw UnimplementedError();
  }

  @override
  Future save(SaveData saveData) async {
    // TODO: implement save
    throw UnimplementedError();
  }
}
