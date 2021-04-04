import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/simple.bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  Future <List<Carro>> loadData(String tipo) async{
    try{
    List<Carro> carros = await CarrosApi.getCarros(tipo);

    add(carros);

    return carros;
  }catch (e){
    addError(e);
    }
  }


}