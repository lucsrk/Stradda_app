import 'dart:async';

import 'package:stradda_01/login/login_api.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';

class LoginBloc{
  final _streamController = StreamController<bool>();

  get buttonstream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async{

    _streamController.add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    _streamController.add(false);

    return response;

  }
  void dispose(){
    _streamController.close();
  }
}