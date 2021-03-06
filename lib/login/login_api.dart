import 'dart:convert';

import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:stradda_01/widgets/prefs.dart';



class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async{
   try{
     var url = 'https://carros-springboot.herokuapp.com/api/v1/login';

     Map <String, String> headers = {
       "Context-Type": "application/json"

     };

     Map params = {
       "username": login,
       "password": senha
     };

     String s = json.encode(params);


     var response = await http.post(url, body: s, headers: headers);
     print('Response status: ${response.statusCode}');
     print('Response body: ${response.body}');

     Map mapResponse = json.decode(response.body);

     if (response.statusCode == 200) {
       final user = Usuario.fromJson(mapResponse);

       user.save();
       return ApiResponse.ok(user);
     }

     return ApiResponse.error(mapResponse["error"]);

   } catch(error, exception){
      print ("Error no login  $error > $exception");
      return ApiResponse.error("Não foi possível fazer o login");
   }
  }
}
