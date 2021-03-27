import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stradda_01/carro/carro.dart';
import 'package:stradda_01/carro/carro_page.dart';
import 'package:stradda_01/carro/carros_api.dart';
import 'package:stradda_01/carro/carros_bloc.dart';
import 'package:stradda_01/utils/nav.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView> {
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
          return Center(
            child: Text(
              "Não possível carregar a lista de carros",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        List<Carro> carros = snapshot.data;
        return _listview(carros);
      },
    );
  }

  _listview(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(3),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];

            return Card(
              color: Colors.grey[200],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        c.urlFoto != null
                            ? c.urlFoto
                            : "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Pagani_Zonda.png",
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      "Descrição",
                      style: TextStyle(fontSize: 16),
                    ),
                    ButtonBarTheme(
                      data: ButtonBarTheme.of(context),
                      child: ButtonBar(
                        children: <Widget>[
                          TextButton(
                            child: const Text(
                              'Detalhes',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () => _OnClickCarro(c),
                          ),
                          TextButton(
                            child: const Text(
                              'Compartilhar',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _OnClickCarro(Carro c) {
    push (context, CarroPage(c));

  }
  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
  }
}