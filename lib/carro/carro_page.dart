import 'package:flutter/material.dart';
import 'package:stradda_01/carro/carro.dart';

class CarroPage extends StatelessWidget {

  Carro carro;


  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text (carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
          icon: Icon(Icons.videocam),
          onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context){
            return[
              PopupMenuItem(value: "Compartilhar",
                  child: Text ("Compartilhar"),),
              PopupMenuItem(value: "Editar",
                child: Text ("Editar"),),
              PopupMenuItem(value: "Deletar",
                child: Text ("Deletar"),),
            ];
          },
          )
      ],
      ),
      body: _body()
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.network(carro.urlFoto),
            Divider(),
            _bloco1(),
            _bloco2(),
          ],
        ));
  }

  Row _bloco1() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(carro.nome,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                  Text(carro.tipo, style: TextStyle(fontSize: 16),),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite, size: 40,),
                    onPressed: _onClickFavorito,
                  ),
                  IconButton(
                    icon: Icon(Icons.share, size: 40,),
                    onPressed: _onClickShare,
                  ),
                ],
              ),
            ],
          );
  }

  _bloco2(){
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        SizedBox( height: 15,),
        Text (carro.descricao, style: TextStyle (fontSize: 16, fontWeight: FontWeight.bold), ),
        SizedBox( height: 20,),
        Text ("ttttt", style: TextStyle (fontSize: 16),),



      ],


    );


  }

  void _onClickMapa() {
  }

  void _onClickVideo() {
  }

  _onClickPopupMenu(String value) {
    switch(value){
      case "Compartilhar":
        print ("Compartilhar !!!");
        break;
      case "Editar":
        print ("Editar !!!");
        break;
      case "Deletar":
        print ("Deletar !!!");
        break;

    }

  }

  void _onClickFavorito() {
  }

  void _onClickShare() {
  }
}
