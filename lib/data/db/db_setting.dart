import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class DbSetting {
  static const String dbName = 'database.db';
  static const int dbVersion = 1;
  late Database db;

  DbSetting() {
    loadDatabase();
  }

  Future<void> deleteDatabaseFile() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, DbSetting.dbName);

      if (await File(path).exists()) {
        await File(path).delete();
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> openDatabaseFromAssets() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    final exists = await File(path).exists();
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
        final ByteData data = await rootBundle.load('assets/db/$dbName');
        final List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        rethrow;
      }
    } else {}
  }

  Future<void> readDatabase() async {
    try {
      final path = join(await getDatabasesPath(), dbName);
      db = await openDatabase(path, version: 1);
    } catch (e) {
      // ignore: avoid_print
    }
  }

  Future<void> loadDatabase() async {
    try {
      // await deleteDatabaseFile(); //Uncomment this line to delete the database file
      await openDatabaseFromAssets();
      await readDatabase();
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<ExceptionEntity, Map<String, dynamic>>> insert(
      {required String table, required Map<String, dynamic> data}) async {
    try {
      int response = await db.insert(table, data);
      //get the inserted
      final result =
          await db.query(table, where: 'id = ?', whereArgs: [response]);
      return Right(result.first);
    } catch (e) {
      return Left(ExceptionEntity(code: 'Error inserting item'));
    }
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    try {
      return await db.query(table);
    } catch (e) {
      return [];
    }
  }

  Future<Either<ExceptionEntity, Map<String, dynamic>>> update(
      {required String table,
      required Map<String, dynamic> values,
      required int id}) async {
    try {
      if (values['id'] != null) values.remove('id');
      await db.update(table, values, where: 'id = ?', whereArgs: [id]);
      Map<String, dynamic> result =
          (await db.query(table, where: 'id = ?', whereArgs: [id])).first;
      return Right(result);
    } catch (e) {
      return Left(ExceptionEntity(code: 'Error updating item'));
    }
  }

  Future<void> delete(String table, int id) async {
    try {
      await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
    }
  }

  Future<Either<ExceptionEntity, List<Map<String, dynamic>>>> getAllFromTable(
      String tableName) async {
    try {
      List<Map<String, dynamic>> result = await db.query(tableName);
      return Right(result);
    } catch (e) {
      return Left(ExceptionEntity(code: 'Error executing query'));
    }
  }

  Future<void> close() async {
    await db.close();
  }

  Future<Either<ExceptionEntity, Map<String, dynamic>>> getById(
      {required String table, required int id}) async {
    try {
      final result = await db.query(table, where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        return Right(result.first);
      } else {
        return Left(ExceptionEntity(code: 'Item not found'));
      }
    } catch (e) {
      return Left(ExceptionEntity(code: 'Error getting item'));
    }
  }

  Future<Either<ExceptionEntity, SearchResultEntity<dynamic>>> search({
    required String table,
    required int page,
    required int itemsPerPage,
    required String? query,
  }) async {
    query = query == null || query.isEmpty ? '' : 'WHERE $query';
    try {
      final count = Sqflite.firstIntValue(
              await db.rawQuery('SELECT COUNT(*) FROM $table $query')) ??
          0;

      if (count == 0) {
        return Left(ExceptionEntity(code: 'No items found'));
      }

      final results = await db.rawQuery(
          'SELECT * FROM $table $query LIMIT $itemsPerPage OFFSET ${page * itemsPerPage}');

      return Right(SearchResultEntity(
        currentPage: page,
        itemsPerPage: itemsPerPage,
        totalItems: count,
        data: results,
        lastpage: (count / itemsPerPage).ceil(),
      ));
    } catch (e) {
      return Left(ExceptionEntity(code: 'Error searching items'));
    }
  }
}
