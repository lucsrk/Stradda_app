import 'dart:convert' as convert;
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/carros/carros_dao.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:http/http.dart' as http;
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';
import "dart:convert" as convert;
import "package:stradda_01/carros/carro.dart";



class TipoCarro {

  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {


  static Future <List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    Map <String, String> headers = {
      "Context-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = "https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future <ApiResponse<bool>> save(Carro c) async {
    try {
      Usuario user = await Usuario.get();

      Map <String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = "https://carros-springboot.herokuapp.com/api/v2/carros";

      if (c.id != null){
        url += "/${c.id}";

      }

      print("Post > $url");

      String json = c.toJson();

      var response = await (
      c.id == null ?
      http.post(url, body: json, headers: headers):
      http.put(url, body: json, headers: headers)
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);

        Carro carro = Carro.fromMap(mapResponse);

        print("Novo Carro: ${carro.id}");

        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível salvar o carro");
    }
  }


}