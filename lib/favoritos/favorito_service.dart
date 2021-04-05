import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/favoritos/favorito.dart';
import 'package:stradda_01/favoritos/favorito_dao.dart';

class FavoritoService{
  static favoritar(Carro c) async{

    Favorito f = Favorito.fromCarro(c);


    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists){
      // Remove dos Favoritos
      dao.delete(c.id);
    }else {
      //Adiciona aos Favoritos
      dao.save(f);
    }




  }
}