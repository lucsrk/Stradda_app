import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:stradda_01/carro/carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros() async {

      var url = "https://carros-springboot.herokuapp.com/api/v1/carros";

      var response = await http.get(url);

      String json = response.body;
      print(json);

      List list = convert.json.decode(json);

      final carros = list.map<Carro>((map)=> Carro.fromJson(map)).toList();


      return carros;


  }
}

