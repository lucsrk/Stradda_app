import 'package:flutter/material.dart';
import 'file:///C:/Users/Lucas/AndroidStudioProjects/stradda_01/lib/pages/home_page.dart';
import 'package:stradda_01/login/login_page.dart';
import 'package:stradda_01/login/usuario.dart';
import 'package:stradda_01/perfil/views/perfil_list.dart';
import 'package:stradda_01/utils/nav.dart';

class DrawerList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   Future <Usuario> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
           FutureBuilder<Usuario>(
             future: future, builder: (context, snapshot){
               Usuario user = snapshot.data;

               return user !=null ? _header(user) : Container();
           },
           ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_search),
              title: Text("Perfil"),
              subtitle: Text("Trocar de perfil"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _OnClickPerfil(context)

            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _OnClickLogout (context),
            )
          ],
        ),
      ),
    );
  }

  _OnClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  _OnClickPerfil(BuildContext context) {
    Navigator.pop(context);
    push(context, PerfilList());
  }
}
