import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'package:stradda_01/carros/carro_form_page.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/loripsum_api.dart';
import 'package:stradda_01/favoritos/favorito_service.dart';
import 'package:stradda_01/pages/api_response.dart';
import 'package:stradda_01/utils/alert.dart';
import 'package:stradda_01/utils/event_bus.dart';
import 'package:stradda_01/utils/nav.dart';

class CarroPage extends StatefulWidget {

  Carro carro;


  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState(){
    super.initState();

    FavoritoService.isFavorito(carro).then ((bool favorito){
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });


    
    _loripsumApiBloc.fetch();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text (widget.carro.nome),
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
        CachedNetworkImage(
        imageUrl: widget.carro.urlFoto ??
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Pagani_Zonda.png"),
            _bloco1(),
            Divider(),
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
                  Text(widget.carro.nome,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                  Text(widget.carro.tipo, style: TextStyle(fontSize: 16),),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite,
                      color: color,
                      size: 40,),
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
        Text (widget.carro.descricao, style: TextStyle (fontSize: 16, fontWeight: FontWeight.bold), ),
        SizedBox( height: 20,),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (!snapshot.hasData) {
            return Center (child: CircularProgressIndicator(),);
        }
           return Text (snapshot.data, style: TextStyle (fontSize: 16));
        },
        ),
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
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        deletar();
        break;

    }

  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(context, carro);
    setState(() {
      color = favorito ? Colors.red : Colors.grey;

    });
  }
  void deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);
    if (response.ok){
      alert (context, "Carro deletado com sucesso", callback: (){
        EventBus.get(context).sendEvent(CarroEvent("carro_deletado", carro.tipo));
        Navigator.pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  void _onClickShare() {
    @override
    void dispose(){
      super.dispose();
    }
  }

}
