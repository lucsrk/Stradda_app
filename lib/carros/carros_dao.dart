import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:stradda_01/carros/carro.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/utils/sql/base_dao.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/utils/sql/db_helper.dart';

// Data Access Object
class CarroDAO extends BaseDAO <Carro>{
  @override

  String get tableName => "carro" ;

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);

  }

  Future<List<Carro>> findAllByTipo(String tipo) async {

    List<Carro> carros = await query('select * from carro where tipo =? ',[tipo]);
    return carros;

  }


}
