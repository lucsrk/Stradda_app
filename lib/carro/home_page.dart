import 'package:flutter/material.dart';
import 'package:stradda_01/carro/carro.dart';
import 'package:stradda_01/carro/carros_api.dart';
import 'package:stradda_01/carro/carros_listview.dart';
import 'package:stradda_01/utils/drawer_list.dart';
import 'package:stradda_01/utils/drawer_list.dart';
import 'package:stradda_01/carro/carros_api.dart';
import 'package:stradda_01/carro/carro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stradda"),
          bottom: TabBar(tabs: [
            Tab(text: "Clássicos",),
            Tab(text: "Esportivos",),
            Tab(text: "Luxo",),
          ],),
        ),
        body: TabBarView(children: [
          CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo),
        ],),
        drawer: DrawerList(),
      ),
    );
  }
}
