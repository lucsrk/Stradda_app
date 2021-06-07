import 'dart:async';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:stradda_01/firebase/firebase_services.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/home_page.dart';
import 'package:stradda_01/login/login_api.dart';
import 'package:stradda_01/login/login_bloc.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';
import 'package:stradda_01/pages/cadastro_page.dart';
import 'package:stradda_01/utils/alert.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/app_button.dart';
import 'package:stradda_01/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _bloc = LoginBloc();

  final _tlogin = TextEditingController();

  final _tsenha = TextEditingController();


  @override
  
  void initState(){
    super.initState();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stradda",style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,

      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginpg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o Login",
              controller: _tlogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,


            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Digite a senha",
              password: true,
              controller: _tsenha,
              validator: _validateSenha,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data,
                );
              }
            ),

            Container (
              height: 46,
              margin: EdgeInsets.only(top: 28),
              child: GoogleSignInButton(
                onPressed: _onClickGoogle,
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: OnClickCadastrar,
                child: RaisedButton(
                  color: Colors.black87,
                  child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void OnClickCadastrar() {
    push(context, CadastroPage(), replace: true);
  }

  void _onClickGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();


    if (response.ok){
      push (context, HomePage(), replace: true);
    }else{
      alert(context, response.msg);
    }
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    String login = _tlogin.text;
    String senha = _tsenha.text;

    print("Login: $login, Senha: $senha");

    ApiResponse response = await _bloc.login(login, senha);
    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }

  }


  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha necessita ter pelos menos 6 dígitos";
    }
    return null;
  }
  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
  }




}
