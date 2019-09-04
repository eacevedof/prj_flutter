//file: utils.dart

import 'package:flutter/material.dart';

bool is_numeric(String strvalue){
  if(strvalue.isEmpty) return false;
  final n = num.tryParse(strvalue);
  return (n==null) ? false : true;
}

void alert(BuildContext context, String msg){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text("Warning !!"),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            //cerramos la alerta
            onPressed: () => Navigator.of(context).pop()
          )
        ],
      );
    }
  );
}//void alert(