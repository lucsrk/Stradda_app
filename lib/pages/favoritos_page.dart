import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stradda_01/carros/carro.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/carro_page.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/carros_bloc.dart';
import 'package:stradda_01/carros/carros_listview.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/favoritos/favorito_service.dart';
import 'package:stradda_01/main.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/text_error.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FavoritoService().stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data.documents.map((DocumentSnapshot document) {
          return Carro.fromMap(document.data);
        }).toList();

        return CarrosListView(carros);
      },
    );
  }
}
