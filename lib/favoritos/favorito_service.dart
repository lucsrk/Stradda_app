import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carros_dao.dart';
import 'package:stradda_01/favoritos/favorito.dart';
import 'package:stradda_01/favoritos/favorito_dao.dart';

class FavoritoService{
  static  Future <bool> favoritar(Carro c) async{

    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists){
      // Remove dos Favoritos
      dao.delete(c.id);

      return false;

    }else {
      //Adiciona aos Favoritos
      dao.save(f);

      return true;
    }
  }
  static Future<List<Carro>> getCarros() async{
    // select * from carro c.favorito f wherec.id = f.id
    List<Carro> carros = await CarroDAO().query("select * from carro c, favorito f where c.id = f.id");

    return carros;

  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();

    bool exists = await dao.exists(c.id);

    return exists;
    }
  }