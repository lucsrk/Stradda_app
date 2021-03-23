import 'package:flutter/material.dart';
import 'package:stradda_01/carro/home_page.dart';
import 'package:stradda_01/login/login_api.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/pages/api_response.dart';
import 'package:stradda_01/utils/alert.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/app_button.dart';
import 'package:stradda_01/widgets/app_text.dart';
import 'package:stradda_01/pages/api_response.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tlogin = TextEditingController();

  final _tsenha = TextEditingController();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stradda"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
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
            AppButton(
              "Login",
              onPressed: _onClickLogin,
              showProgress: _showProgress,
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    String login = _tlogin.text;
    String senha = _tsenha.text;

    print("Login: $login, Senha: $senha");

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(login, senha);
    if (response.ok) {
      Usuario user = response.result;

      print(">>> $user");
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
    setState(() {
      _showProgress = false;
    });
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
      return "A senha necessita ter pelos menos 8 dígitos";
    }
    return null;
  }
}
