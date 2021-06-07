import 'dart:convert' as convert;
import 'dart:io';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/carros/carros_dao.dart';
import 'package:stradda_01/carros/upload_api.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import "package:stradda_01/utils/http_helper.dart" as http;
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

    var url = "https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo";

    print("GET > $url");

    var response = await http.get(url);

    String json = response.body;

    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future <ApiResponse<bool>> save(Carro c, File file ) async {
    try {
          if (file != null)  {
          ApiResponse<String> response = await UploadApi.upload(file);
            if(response.ok){
              String urlFoto = response.result;
              c.urlFoto = urlFoto;
            }
          }

      var url = "https://carros-springboot.herokuapp.com/api/v1/carros";

      if (c.id != null){
        url += "/${c.id}";

      }

      print("Post > $url");

      String json = c.toJson();

      var response = await (
      c.id == null ?
      http.post(url, body: json):
      http.put(url, body: json)
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

  static delete(Carro c)  async{
    try {

      var url = "https://carros-springboot.herokuapp.com/api/v1/carros/${c.id}";

      var response = await http.delete(url);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 ) {

        return ApiResponse.ok(true);
      }
      return ApiResponse.error("Não foi deletar salvar o carro");


    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível deletar o carro");
    }
  }


}