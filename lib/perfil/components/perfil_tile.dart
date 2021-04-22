




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stradda_01/perfil/provider/perfis.dart';
import 'package:stradda_01/perfil/routes/routes.dart';
import 'package:stradda_01/perfil/user_perfil.dart';

class PerfilTile extends StatelessWidget {

  final Perfil user;

  const PerfilTile(this.user);
  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
    ? CircleAvatar(child: Icon (Icons.person))
    : CircleAvatar (backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar ,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget> [
            IconButton(
                icon: Icon(Icons.edit,
                color: Colors.black,),
            onPressed: (){
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: user,
              );
            },
            ),
            IconButton(
              icon: Icon (Icons.delete,
              color: Colors.red,),
              onPressed: (){
                showDialog(context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content: Text('Tem certeza que quer excluir este perfil?'),
                      actions:<Widget>
                      [
                        FlatButton(
                          child: Text ('Não'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },

                        ),
                        FlatButton(
                          child: Text ('Sim'),
                          onPressed: (){
                            Provider.of<Perfis>(context, listen: false).remove(user);
                            Navigator.of(context).pop();
                          },

                        ),
                      ],
                    ));
              }
           ),

          ],

        ),
      ),

    );
  }


}
