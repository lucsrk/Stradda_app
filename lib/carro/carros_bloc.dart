import 'dart:async';

import 'package:stradda_01/carro/carro.dart';
import 'package:stradda_01/carro/carros_api.dart';

class CarrosBloc{

  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  loadData(String tipo) async{
    try{
    List<Carro> carros = await CarrosApi.getCarros(tipo);

    _streamController.add(carros);
  }catch (e){
      _streamController.addError(e);
    }
  }

  void dispose(){
    _streamController.close();
  }

}