import 'package:flutter/material.dart';
import 'package:stradda_01/carros/home_page.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/utils/sql/db_helper.dart';
import 'package:stradda_01/login/login_page.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/utils/nav.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override

  void initState(){

    // Inicializar o Banco de Dados

    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds:3));

    //Usuario
    Future<Usuario> futureC = Usuario.get();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      print (user);
      if (user != null) {
        push(context, HomePage(), replace: true);
      } else

      push (context, LoginPage(),replace: true);
    });

  }

  // ALTERAR CONTAINER PARA LOGO DO APP
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
