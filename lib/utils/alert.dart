

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

  alert (BuildContext context, String msg, {Function callback}){

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context){
      return WillPopScope(
       onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Stradda"),
          content: Text(msg) ,
          actions: <Widget>[
              FlatButton(
                  child: Text("Ok"),
                  onPressed: (){
                    Navigator.pop(context);
                    if (callback != null){
                      callback();
                    }

                  },
              ),
          ],

        ),
      );
    },

  );

}