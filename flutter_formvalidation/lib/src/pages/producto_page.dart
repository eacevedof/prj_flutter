//file: producto_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:flutter_formvalidation/src/providers/productos_provider.dart';
import 'package:flutter_formvalidation/src/utils/utils.dart' as u;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {

  ProductoPage({Key key}) : super(key: key);

  _ProductoPageState createState() => _ProductoPageState();

}

class _ProductoPageState extends State<ProductoPage> {

  //definiendo así la variable se informa a Flutter que 
  //esta representa a la config del formulario
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final productoprov = new ProductosProvider();
  bool _guardando = false;
  File foto;

  //tengo que saber si es nuevo o ya existía, viene con algún argumento
  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    //aqui viene el dato de la otra pantalla
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData!=null){
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: seleccionar_foto_async,
            //onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomar_foto_async,
            //onPressed: (){},
          ),          
        ],
      ),
      
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          //es un contenedor con validación
          child: Form(
            key: formkey,//el id del formulario
            child: Column(
              children: <Widget>[
                _get_foto_wg(),
                _get_field_nombre_wg(),
                _get_field_precio_wg(),
                _get_is_disponible_wg(),
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
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Producto",
      ),
      //se ejecuta despues de haber validado el campo
      onSaved: (value) => producto.titulo = value,
      validator: (strvalue){
        //si no hay errores tiene que devolver null
        if(strvalue.length<3){
          //error:
          return "Ingrese el nombre del producto";
        }
        //todo ha ido bien
        return null;
      },
    );
  }//_get_field_nombre_wg

  Widget _get_field_precio_wg(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "Precio",
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (strvalue){
        if(u.is_numeric(strvalue)){
          return null;
        }
        else{
          return "solo numeros";
        }
      },

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
      onPressed: (_guardando) ? null:_submit,
    );

  }//_get_button_wg

  //aqui necesito tomar una referencia al formulario
  //en otros casos hemos usado un controlador pero Form no tiene esa posibilidad
  void _submit() async {
    bool isValid = formkey.currentState.validate();
    if(!isValid) return;

    //guarda el estado de lo que hay en los inputs de modo que
    //el modelo se actualiza con estos datos
    formkey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null){
      producto.fotoUrl = await productoprov.subir_imagen_async(foto);
    }
    
    if(producto.id == null){
      productoprov.getasync_producto(producto);
    }
    else{
      productoprov.getasync_productoup(producto);
    }

    //setState(() { _guardando = false; });
    _get_snackbar_wg("registro guardado");
    //hace un redirect al listado
    Navigator.pop(context);
  }//_submit

  Widget _get_is_disponible_wg(){
    //check horizontal
    return SwitchListTile(
      value: producto.disponible,
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      }),
    );
  }//_get_is_disponible_wg

  //el snackbar es como un alert pero en el pie
  void _get_snackbar_wg(String message){
    //se necesita la referencia al scaffoldstate
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(microseconds: 1500),
    );

    //esto muestra el snackbar en la pantalla del formulario
    scaffoldkey.currentState.showSnackBar(snackbar);

  }//_get_snackbar_wg

  //espacio para mostrar la fotografia
  Widget _get_foto_wg(){
    print("_get_foto_wg producto.fotoUrl:"+producto.fotoUrl.toString());
    if(producto.fotoUrl != null){
      print("producto_page._get_foto_wg: existe la imagen??");
      //tengo q arreglar esto
      return Container();
    }
    else{
      print("producto_page._get_foto_wg: no existe imagen");
      return Image(
        //si no existe la 
        image: AssetImage(foto?.path ?? "assets/no-image.png"),
        height: 300.0,
        fit: BoxFit.cover
      );
    }

  }//_get_foto_wg

  seleccionar_foto_async()  {
    _procesar_imagen_async(ImageSource.gallery);
  }

  _tomar_foto_async()  {
    _procesar_imagen_async(ImageSource.camera);
  }

  _procesar_imagen_async(ImageSource origen) async{
    foto = await ImagePicker.pickImage(
      source: origen,
    );
    //cancela o no selecciona
    if(foto != null){
      //limpieza
    }

    setState(() {});   
  }//_procesar_imagen_async

}//class _ProductoPageState