import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carro_page.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/carros_bloc.dart';
import 'package:stradda_01/carros/carros_listview.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/favoritos/favoritos_bloc.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/text_error.dart';

class FavoritosPage extends StatefulWidget {

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

  final _bloc = FavoritosBloc();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      _bloc.loadData();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream:_bloc.stream ,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível carregar os carros :d");

        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarrosListView(carros));
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.loadData();
  }

}