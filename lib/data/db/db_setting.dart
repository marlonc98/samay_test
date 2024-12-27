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
        print("Base de datos eliminada: $path");
      } else {
        print("No se encontró la base de datos en: $path");
      }
    } catch (e) {
      print("Error al eliminar la base de datos: $e");
    }
  }

  /// Copia la base de datos desde los assets si no existe
  Future<void> openDatabaseFromAssets() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    print("Ruta de la base de datos: $path");

    final exists = await File(path).exists();
    if (!exists) {
      print("La base de datos no existe. Copiando desde los assets...");
      try {
        await Directory(dirname(path)).create(recursive: true);
        final ByteData data = await rootBundle.load('assets/db/$dbName');
        final List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
        print("Base de datos copiada con éxito a $path");
      } catch (e) {
        print("Error copiando la base de datos: $e");
        rethrow;
      }
    } else {
      print("La base de datos ya existe en $path.");
    }
  }

  /// Abre la base de datos para leer/escribir
  Future<void> readDatabase() async {
    try {
      final path = join(await getDatabasesPath(), dbName);
      db = await openDatabase(path, version: 1);
      print("Base de datos cargada exitosamente desde $path");
    } catch (e) {
      print("Error al abrir la base de datos: $e");
      rethrow;
    }
  }

  /// Carga la base de datos desde los assets y la abre
  Future<void> loadDatabase() async {
    try {
      // await deleteDatabaseFile();
      await openDatabaseFromAssets();
      await readDatabase();
      List<Map<String, dynamic>> tables = await db
          .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
      print("Tablas disponibles: $tables");
    } catch (e) {
      print("Error al cargar la base de datos: $e");
    }
  }

  /// Inserta un registro en una tabla
  Future<Either<ExceptionEntity, Map<String, dynamic>>> insert(
      {required String table, required Map<String, dynamic> data}) async {
    try {
      print("Insertando en $table: $data");
      int resposne = await db.insert(table, data);
      //get the inserted
      final result =
          await db.query(table, where: 'id = ?', whereArgs: [resposne]);
      print("Registro insertado en $table: $data");
      return Right(result.first);
    } catch (e) {
      print("Error al insertar en $table: $e");
      return Left(ExceptionEntity(code: 'Error inserting item'));
    }
  }

  /// Consulta todos los registros de una tabla
  Future<List<Map<String, dynamic>>> query(String table) async {
    try {
      return await db.query(table);
    } catch (e) {
      print("Error al consultar $table: $e");
      return [];
    }
  }

  /// Actualiza registros en una tabla
  Future<Either<ExceptionEntity, Map<String, dynamic>>> update(
      {required String table,
      required Map<String, dynamic> values,
      required int id}) async {
    try {
      //if values has id remove
      if (values['id'] != null) values.remove('id');
      await db.update(table, values, where: 'id = ?', whereArgs: [id]);
      print("Registro actualizado en $table con ID $id: $values");
      //get the updated
      Map<String, dynamic> result =
          (await db.query(table, where: 'id = ?', whereArgs: [id])).first;
      return Right(result);
    } catch (e) {
      print("Error al actualizar en $table: $e");
      return Left(ExceptionEntity(code: 'Error updating item'));
    }
  }

  /// Elimina un registro por ID
  Future<void> delete(String table, int id) async {
    try {
      await db.delete(table, where: 'id = ?', whereArgs: [id]);
      print("Registro eliminado de $table con ID $id");
    } catch (e) {
      print("Error al eliminar en $table: $e");
    }
  }

  /// Cierra la conexión con la base de datos
  Future<void> close() async {
    await db.close();
    print("Conexión a la base de datos cerrada.");
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

  /// Realiza una búsqueda con paginación
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
      print(
          'SELECT * FROM $table $query LIMIT $itemsPerPage OFFSET ${page * itemsPerPage}');

      return Right(SearchResultEntity(
        currentPage: page,
        itemsPerPage: itemsPerPage,
        totalItems: count,
        data: results,
        lastpage: (count / itemsPerPage).ceil(),
      ));
    } catch (e) {
      print("Error al realizar la búsqueda en $table: $e");
      return Left(ExceptionEntity(code: 'Error searching items'));
    }
  }
}
