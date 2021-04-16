import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
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

            return Container(
              child: InkWell(
                onTap: (){
                  _OnClickCarro(context, c);
                },
                onLongPress:() {
                  _onLongClickCarro(context, c);
                },
              child: Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl:
                           c.urlFoto
                              ?? "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Pagani_Zonda.png",
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
                                _OnClickShare(context, c);
                                /* ... */
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            );
          }),
    );
  }

  _OnClickCarro(context, Carro c) {
    push (context, CarroPage(c));

  }

  void _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(c.nome, style: TextStyle (fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title:  Text("Detalhes"),
            leading: Icon(Icons.directions_car),
            onTap: (){
              Navigator.pop(context);
              _OnClickCarro(context, c);
            },
          ),
          ListTile(
            title:  Text("Compartilhar"),
              leading: Icon (Icons.share),
              onTap:() {
                Navigator.pop(context);
                _OnClickShare(context, c);
              }
          )

        ],
      );
    });
  }

  void _OnClickShare(BuildContext context, Carro c) {
    print ("Share ${c.nome}");

    Share.share(c.urlFoto);
  }
}