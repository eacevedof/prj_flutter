//file:validators.dart

import 'dart:async';

class Validators {
  //<string,string> = <entrada y salida>
  //streamTransformer público
  final validarPass = StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink){
      if (password.length>= 6){
        //es válido y q continue el pass
        sink.add(password);
      }
      else{
        sink.addError("más de 6 caracteres por favor");
      }
    }
  );
  
  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add(email);
      }
      else
      {
        sink.addError("email incorrecto");
      }
    }
  );  

}//class Validators