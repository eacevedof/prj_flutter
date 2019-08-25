//file: producto_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:flutter_formvalidation/src/providers/productos_provider.dart';
import 'package:flutter_formvalidation/src/utils/utils.dart' as u;

class ProductoPage extends StatefulWidget {

  ProductoPage({Key key}) : super(key: key);

  _ProductoPageState createState() => _ProductoPageState();

}

class _ProductoPageState extends State<ProductoPage> {

  //definiendo así la variable se informa a Flutter que 
  //esta representa a la config del formulario
  final formkey = GlobalKey<FormState>();
  final productoprov = new ProductosProvider();

  ProductoModel producto = new ProductoModel();

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
            key: formkey,//el id del formulario
            child: Column(
              children: <Widget>[
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
      onPressed: _submit,
    );

  }//_get_button_wg

  //aqui necesito tomar una referencia al formulario
  //en otros casos hemos usado un controlador pero Form no tiene esa posibilidad
  void _submit(){
    bool isValid = formkey.currentState.validate();
    if(!isValid) return;

    //guarda el estado de lo que hay en los inputs de modo que
    //el modelo se actualiza con estos datos
    formkey.currentState.save();
    print("todo ok");
    print("titulo:"+producto.titulo);
    print("valor:"+producto.valor.toString());
    print("disponible:"+producto.disponible.toString());
    
    productoprov.getasync_producto(producto);

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

}//class _ProductoPageState