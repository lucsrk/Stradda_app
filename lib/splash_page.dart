import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stradda_01/firebase/firebase_services.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/home_page.dart';
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
    Future<FirebaseUser> futureC = FirebaseAuth.instance.currentUser();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      FirebaseUser fUser = values[2];
     print (fUser);
      if (fUser != null) {
        firebaseUserUid = fUser.uid;
        push(context, HomePage(), replace: true);
      } else

      push (context, LoginPage(),replace: true);
    });

  }

  // ALTERAR CONTAINER PARA LOGO DO APP
  Widget build(BuildContext context) {
    return Container(
      //lembar de por logo do app
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
