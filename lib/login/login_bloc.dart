import 'dart:async';

import 'package:stradda_01/carros/simple.bloc.dart';
import 'package:stradda_01/firebase/firebase_services.dart';
import 'package:stradda_01/login/login_api.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';

class LoginBloc extends BooleanBloc{
  Future<ApiResponse> login(String login, String senha) async {
    add(true);

   // ApiResponse response = await LoginApi.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha);

    add(false);

    return response;
  }
}
