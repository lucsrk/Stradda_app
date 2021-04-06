import 'dart:async';

import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/simple.bloc.dart';
import 'package:stradda_01/favoritos/favorito_service.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/carros/carros_dao.dart';
import 'package:stradda_01/utils/network.dart';

class FavoritosBloc {

  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  Future <List<Carro>> loadData() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();

      _streamController.add(carros);

      return carros;
    } catch (e) {
      print(e);
      if (!_streamController.isClosed) {
        _streamController.addError(e);
      }
    }
    void dispose (){
      _streamController.close();
    }
  }
}