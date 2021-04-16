
import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/favoritos/favorito_service.dart';

class FavoritosModel extends ChangeNotifier {
  List<Carro> carros = [];

  Future<List<Carro>> getCarros() async {
    carros = await FavoritoService.getCarros();

    notifyListeners();

    return carros;
  }
}