//file:login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //stack: div que permite colapsar elementos
      body: Stack(
        children: <Widget>[
          _get_fondo_wg(context),
          _get_loginform_wg(context),
        ],
      ),
    );
  }//build

  Widget _get_email_wg(LoginBloc bloc){
    
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,color: Colors.deepPurple),
              hintText: "ejemplo@correo.com",
              labelText: "Un correo electronico",
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail, //el primer argumento se pasará al primer argumento de changeEmail
          ),

        );
      },
    );

  }//_get_email_wg

  Widget _get_password_wg(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,color: Colors.deepPurple),
              labelText: "Contraseña",
              counterText: snapshot.data,
              //errorText: "no es un dato válido"  //si hay texto se pone rojo si es null se queda en su color
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePass,
          ),
        );
      },
    );
  
  }//_get_password_wg

  Widget _get_raisedbutton_wg(BuildContext context, LoginBloc bloc){
    //formValidStream
    //snapshot.hasData
    //true ? algo si true:
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text("Ingresar"),

          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          //null desactiva el botón
          onPressed: snapshot.hasData ? () {} :null,
        );
      },
    );

  }//_get_raisedbutton_wg


  Widget _get_loginform_wg(BuildContext context){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    //ojo! no se usa un ListView
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text("Ingreso", style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0,),
                _get_email_wg(bloc),
                SizedBox(height: 30.0,),
                _get_password_wg(bloc),
                SizedBox(height: 30.0,),
                _get_raisedbutton_wg(context,bloc),
              ],
            )
          ),

          Text("¿Olvidó la contraseña?"),
          
          SizedBox(height: 100.0,),
        ],
      )
    );
  }//_get_loginform_wg

  Widget _get_fondo_wg(BuildContext context){
    final size = MediaQuery.of(context).size;

    final fondomorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 15, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        )
      ),
    );
  
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        fondomorado,
        //permite aplicar una coordenada de posicion
        Positioned(top:90.0,left: 30.0,child:circulo),
        Positioned(top:-40.0,right: -30.0,child:circulo),
        Positioned(bottom:-50.0,right: -10.0,child:circulo),
        Positioned(bottom:120.0,right: -20.0,child:circulo),
        Positioned(bottom:-50.0,left: -20.0,child:circulo),
        
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color:Colors.white, size:100.0),
              SizedBox(height: 10.0, width: double.infinity,),
              Text("Eduardo A. F.", style: TextStyle(color: Colors.white, fontSize: 25.0),)
            ],
          ),
        ),
      ],
    );

  }//_get_fondo_wg 

}//class LoginPage