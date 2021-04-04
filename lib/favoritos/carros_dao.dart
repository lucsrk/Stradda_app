import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/favoritos/base_dao.dart';
import 'package:stradda_01/favoritos/db_helper.dart';

// Data Access Object
class CarroDAO extends BaseDAO <Carro>{
  @override

  String get tableName => "carro" ;

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);

  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $tableName where tipo =? ',[tipo]);

    return list.map<Carro>((json) => fromMap(json)).toList();

  }


}
