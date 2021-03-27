import 'dart:async';

import 'package:stradda_01/carro/simple.bloc.dart';
import 'package:stradda_01/login/login_api.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';

class LoginBloc extends BooleanBloc{
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}
