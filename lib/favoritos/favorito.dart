 import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/utils/sql/entity.dart';
import 'package:stradda_01/carros/carro.dart';

class Favorito extends Entity{

  int id;
  String nome;

  Favorito.fromCarro(Carro c){
    id = c.id;
    nome = c.nome;
  }

  Favorito.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }


}