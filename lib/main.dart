import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stradda_01/favoritos/favoritos_model.dart';
import 'package:stradda_01/perfil/provider/perfis.dart';
import 'package:stradda_01/perfil/routes/routes.dart';
import 'package:stradda_01/perfil/user_perfil.dart';
import 'package:stradda_01/perfil/views/user_form.dart';

import 'package:stradda_01/splash_page.dart';
import 'package:stradda_01/utils/event_bus.dart';

import 'login/login_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider <Perfis>(
          create: (context) =>Perfis(),
        ),
        Provider<EventBus>(
            create: (context) => EventBus(),
            dispose: (context, bus) => bus.dipose(),
        ),
        ChangeNotifierProvider <FavoritosModel>(
          create : (context) => FavoritosModel(),
        )
      ],


      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(

        ),
        routes: {
          AppRoutes.USER_FORM: (_) => UserForm()
        }
      ),
    );
  }
}
