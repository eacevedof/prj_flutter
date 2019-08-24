//file: producto_page.dart
import 'package:flutter/material.dart';

class ProductoPage extends StatefulWidget {

  ProductoPage({Key key}) : super(key: key);

  _ProductoPageState createState() => _ProductoPageState();

}

class _ProductoPageState extends State<ProductoPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){

            },
          ),          
        ],
      ),
      
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          //es un contenedor con validación
          child: Form(
            child: Column(
              children: <Widget>[
                _get_field_nombre_wg(),
                _get_field_precio_wg(),
                _get_button_wg(),
              ],
            ),
          ),

        ),

      ),
    );

  }//build

  Widget _get_field_nombre_wg(){
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Producto",
      ),
    );
  }//_get_field_nombre_wg

  Widget _get_field_precio_wg(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "Precio",
      ),
    );
  }//_get_field_precio_wg

  Widget _get_button_wg(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple, //background
      textColor: Colors.white,  //color
      label: Text("Guardar"),   //innerhtml
      icon: Icon(Icons.save),   //span
      onPressed: (){

      },
    );
  }//_get_button_wg

}//class _ProductoPageState