

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stradda_01/perfil/provider/perfis.dart';
import 'package:stradda_01/perfil/user_perfil.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(Perfil perfil){
    if(perfil != null) {
      _formData ['id'] = perfil.id;
      _formData ['name'] = perfil.name;
      _formData ['email'] = perfil.email;
      _formData ['avatarUrl'] = perfil.avatarUrl;
    }
  }
  @override
  Widget build(BuildContext context) {

    final Perfil perfil = ModalRoute.of(context).settings.arguments;

    _loadFormData(perfil);


    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Perfil"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
               final isValid =  _form.currentState.validate();

               if (isValid) {
                 _form.currentState.save();
                 Provider.of<Perfis>(context, listen: false).put(Perfil(
                   id: _formData['id'],
                   name: _formData['name'],
                   email: _formData['email'],
                   avatarUrl: _formData['avatarUrl'],
                 ),
                 );
                 Navigator.of(context).pop();
               }
              },
              ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
            TextFormField(
              initialValue: _formData['name'],
              decoration: InputDecoration(
                  labelText: 'Nome'),
              validator: (value){
                if (value == null || value.trim().isEmpty) {
                  return 'Informe um Nome';
                }
                if (value.trim().length <= 3 ){
                  return 'Nome Inválido. Necessita ter ao menos 3 letras ';
                }
                return null;
              },
              onSaved: (value) => _formData['name'] = value,
            ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(
                    labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(
                    labelText: 'Url do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
