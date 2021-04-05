import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/utils/sql/base_dao.dart';
import 'package:stradda_01/favoritos/favorito.dart';

class FavoritoDAO extends BaseDAO<Favorito>{
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";


}