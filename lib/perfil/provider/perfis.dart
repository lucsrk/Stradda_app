import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stradda_01/perfil/data/dammy_perfil.dart';
import 'package:stradda_01/perfil/user_perfil.dart';





class Perfis with ChangeNotifier{

  final Map<String, Perfil> _items = {...DUMMY_PERFIL};


  List<Perfil> get all{
    return[... _items.values];
  }

  int get count{
    return _items.length;
  }

  Perfil byIndex (int i){

    return _items.values.elementAt(i);
  }


  //inlcue ou altera

  void put (Perfil perfil){
    if(perfil == null){
      return;
    }

    if(perfil.id != null &&
        perfil.id.trim().isNotEmpty
        && _items.containsKey(perfil.id)){
      _items.update(perfil.id, (_) => Perfil(
        id: perfil.id,
        name: perfil.name,
        email: perfil.email,
        avatarUrl: perfil.avatarUrl,
      ));
    }else{
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(id, () => Perfil(
          id: id,
          name: perfil.name,
          email: perfil.email,
          avatarUrl: perfil.avatarUrl));
    }
        notifyListeners();
    }
    void remove(Perfil perfil){
        if ( perfil != null && perfil.id
        != null){
          _items.remove(perfil.id);
          notifyListeners();
        }
    }
    }


