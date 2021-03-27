import 'package:stradda_01/carro/carro.dart';
import 'package:stradda_01/carro/carros_api.dart';
import 'package:stradda_01/carro/simple.bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  loadData(String tipo) async{
    try{
    List<Carro> carros = await CarrosApi.getCarros(tipo);

    add(carros);
  }catch (e){
    addError(e);
    }
  }


}