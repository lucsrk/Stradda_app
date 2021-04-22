import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stradda_01/carros/carro.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/carro_page.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/carros_bloc.dart';
import 'package:stradda_01/carros/carros_listview.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/favoritos/favoritos_model.dart';
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    model.getCarros();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritosModel model = Provider.of<FavoritosModel>(context);

    List<Carro> carros = model.carros;

    if(carros.isEmpty){
      return Center(
        child: Text("Nenhum Favoritado", style: TextStyle( fontSize: 25),),
      );
    }

        return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarrosListView(carros));

  }

  Future<void> _onRefresh() {
    return  Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }

}