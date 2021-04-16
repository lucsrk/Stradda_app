import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stradda_01/favoritos/favoritos_model.dart';

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
      ),
    );
  }
}
