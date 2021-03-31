import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stradda_01/carro/carro.dart';
import 'package:stradda_01/carro/carro_page.dart';
import 'package:stradda_01/carro/carros_api.dart';
import 'package:stradda_01/carro/carros_bloc.dart';
import 'package:stradda_01/carro/carros_listview.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/text_error.dart';

class CarrosPage extends StatefulWidget {
  String tipo;


  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage> with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;

  final _bloc = CarrosBloc();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      _bloc.loadData(widget.tipo);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
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
    return _bloc.loadData(widget.tipo);
  }



  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
  }

}