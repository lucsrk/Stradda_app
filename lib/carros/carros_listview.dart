import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carro_page.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/carros_bloc.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/text_error.dart';

class CarrosListView extends StatelessWidget {

  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () => _OnClickCarro(context, c),
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

  _OnClickCarro(context, Carro c) {
    push (context, CarroPage(c));

  }
}