import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/simple.bloc.dart';
import 'package:stradda_01/favoritos/carros_dao.dart';
import 'package:stradda_01/utils/network.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  Future <List<Carro>> loadData(String tipo) async{
    try{
      if(! await isNetworkOn()){
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
    List<Carro> carros = await CarrosApi.getCarros(tipo);

      if(carros.isNotEmpty) {
        final dao = CarroDAO();
        // Salvar todos os carros
        carros.forEach(dao.save);
      }

    add(carros);

    return carros;
  }catch (e){
    addError(e);
    }
  }


}