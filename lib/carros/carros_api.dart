import 'dart:convert' as convert;
import 'package:stradda_01/favoritos/carros_dao.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:http/http.dart' as http;
import 'package:stradda_01/login/usuario.dart';

class TipoCarro {

  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {


  static Future<List<Carro>> getCarros(String tipo) async {

    Usuario user = await Usuario.get();

    Map <String, String> headers = {
      "Context-Type": "application/json",
      "Authorization": "Bearer ${user.token}"

    };

      var url = "https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";

      var response = await http.get(url, headers: headers );

      String json = response.body;

      List list = convert.json.decode(json);

      final carros = list.map<Carro>((map)=> Carro.fromMap(map)).toList();

      final dao = CarroDAO();

      // Salvar todos os carros

      carros.forEach(dao.save);


      return carros;



  }
}

