import 'dart:io';

import 'package:ge0tic/src/utils/constantes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static const String _dbName = "siccdb.db"; // Use this class as a singleton
  DBProvider._privateConstructor();
  static Database? _database;

  static final DBProvider db = DBProvider._privateConstructor();

  Future<Database?> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _dbName);

    return await openDatabase(path,
        version: Constantes.dbVersion, // incrementar cuando cambie la DB
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constantes.tablaUsuario}(
          id INTEGER PRIMARY KEY,
          usuario TEXT,
          password TEXT,
          id_usuario INTEGER,
          token_jwt TEXT,
          mail TEXT,
          identificationNumber TEXT,
          extension TEXT,
          complement TEXT,
          phoneNumber TEXT
        )
        ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constantes.tablaNotificaciones}(
          id INTEGER PRIMARY KEY,
          id_meeting TEXT,
          title_notification TEXT,
          desc_notification TEXT,
          noread_notification INTEGER
        )  
        ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constantes.tablaTokenFireBase}(
          id INTEGER PRIMARY KEY,
          tokenFB TEXT
        )
        ''');
    });
  }

  Future<bool> tableIsEmpty(String nombreTabla) async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT * FROM $nombreTabla;
    ''');
    // ignore: unnecessary_null_comparison
    return res != null
        ? res.isEmpty
            ? true
            : false
        : false;
  }

  Future<void> deleteTable(String nameTable) async {
    try {
      final db = await database;
      await db!.delete(nameTable);
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  /* CRUD USUARIO */
  Future<int?> insertUsuario(
      int id,
      String usuario,
      String password,
      int idUsuario,
      String tkJwt,
      String ci,
      String ext,
      String compl,
      String telf) async {
    final db = await database;
    final res = await db?.rawInsert('''
      INSERT INTO ${Constantes.tablaUsuario} (
        id, usuario, password, id_usuario, token_jwt, mail, identificationNumber, extension, complement, phoneNumber)
      VALUES ($id, '$usuario', '$password', $idUsuario, '$tkJwt', '$usuario', '$ci', '$ext', '$compl', '$telf');
    ''');
    return res;
  }

  Future<String> getTokenJWT() async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT token_jwt FROM ${Constantes.tablaUsuario}
    ''');
    String x = res!.isNotEmpty ? res[0]['token_jwt'].toString() : '';
    return x;
  }

  Future<void> updateTokenJWT(String jwt) async {
    final db = await database;
    await db?.update(Constantes.tablaUsuario, {"token_jwt": jwt});
  }

  Future<String> getTokenFB() async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT tokenFB FROM ${Constantes.tablaTokenFireBase}
    ''');
    String x = res!.isNotEmpty ? res[0]['tokenFB'].toString() : '';
    return x;
  }

  Future<String> getTokenSession() async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT token_jwt FROM ${Constantes.tablaUsuario}
    ''');
    String x = res!.isNotEmpty ? res[0]['token_jwt'].toString() : '';
    return x;
  }

  Future<String> getUsuario() async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT usuario FROM ${Constantes.tablaUsuario}
    ''');
    String x = res!.isNotEmpty ? res[0]['usuario'].toString() : '';
    return x;
  }

  Future<String> getPassword() async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT password FROM ${Constantes.tablaUsuario}
    ''');
    String x = res!.isNotEmpty ? res[0]['password'].toString() : '';
    return x;
  }

  Future<int?> updatePasswordUsuario(String usuario, String password) async {
    final db = await database;
    final res = await db?.rawUpdate('''
      UPDATE ${Constantes.tablaUsuario}
      SET  password = ?
      WHERE usuario=?
    ''', [password, usuario]);
    return res;
  }

  Future<int?> updateToken(String usuario, String tk) async {
    final db = await database;
    final res = await db!.rawUpdate('''
      UPDATE ${Constantes.tablaUsuario}
      SET  token =?
      WHERE usuario=?
    ''', [tk, usuario]);
    return res;
  }

  Future<void> deleteUsuario() => deleteTable(Constantes.tablaUsuario);

  //////////////////////////////////////////////////////////////////////
  /* CRUD PARAMETRICAS */
  /* CRUD OBSERVACIONES */
  /* CRUD FOTOS */

  Future<void> deleteTablaNotificaciones() =>
      deleteTable(Constantes.tablaNotificaciones);

  /* NOTIFICACIONES */
  Future<int?> insertNotificacion(
      String idMeeting, String titleNotification, String desc) async {
    final db = await database;
    final res = await db?.rawInsert('''
      INSERT  INTO ${Constantes.tablaNotificaciones}
      VALUES (NULL, '$idMeeting',  '$titleNotification', '$desc', 1)
    ''');
    return res;
  }

  Future<int?> updateNotificacion(int id, String idMeeting) async {
    final db = await database;
    final res = await db?.rawInsert('''
      UPDATE ${Constantes.tablaNotificaciones}
      SET noread_notification = 0
      WHERE 
      noread_notification = 1 AND 
      id = $id AND 
      id_meeting = '$idMeeting'
    ''');
    return res;
  }

  Future<List> getNotificaciones() async {
    final db = await database;
    List ln = [];
    final res = await db!.rawQuery('''
      SELECT * FROM ${Constantes.tablaNotificaciones}
    ''');
    res.toList();
    ln = res;
    return ln;
  }

  Future deleteNotificacionID(int id) async {
    final db = await database;
    int c = await db!.rawDelete(
        ' DELETE FROM ${Constantes.tablaNotificaciones} WHERE id = ?', [id]);
    return c;
  }
}
