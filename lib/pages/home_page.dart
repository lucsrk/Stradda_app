import 'package:flutter/material.dart';
import 'package:stradda_01/carros/carro.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/carro_form_page.dart';
import 'package:stradda_01/carros/carros_api.dart';
import 'package:stradda_01/carros/carros_listview.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/carros_page.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/favoritos_page.dart';
import 'package:stradda_01/utils/alert.dart';
import 'package:stradda_01/utils/drawer_list.dart';
import 'package:stradda_01/utils/nav.dart';
import 'package:stradda_01/widgets/prefs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {

    // Primeiro busca o índice nas prefs.
    int tabIdx = await Prefs.getInt("tabIdx");

    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 4, vsync: this);


    // chama o setState para redesenhar a tela
    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Luxo",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            )
          ],
        ),
      ),
      body: _tabController == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : TabBarView(
        controller: _tabController,
        children: [
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo),
          FavoritosPage(),
        ],
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ) ,

    );
  }

  void _onClickAdicionarCarro() {
    push (context, CarroFormPage());
  }
}