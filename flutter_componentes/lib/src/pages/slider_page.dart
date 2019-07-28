//@file: slider_page.dart
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}// SliderPage

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),

      body: Container(
        padding: EdgeInsets.only(top:50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _crearCheckbox(),
            _crearSwitch(),
            //_crearImagen(),
            Expanded(child: _crearImagen()),
          ],
        )
      ),
    );
  }// build

  //es como un radio horizontal
  Widget _crearSwitch(){
    //listtile a diferencia de checkbox a secas, permite que se haga click en toda la linea
    return SwitchListTile( 
      title: Text("Bloquear slider"),
      value: _bloquearCheck,      
      onChanged: (valor){
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );
  }// _crearSwitch  

  Widget _crearCheckbox(){
    //listtile a diferencia de checkbox a secas, permite que se haga click en toda la linea
    return CheckboxListTile( 
      value: _bloquearCheck,
      title: Text("Bloquear slider"),
      onChanged: (valor){
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );
    
    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (valor){
    //     setState(() {
    //       _bloquearCheck = valor;
    //     });
    //   },
    // );

  }// _crearCheckbox

  Widget _crearSlider(){
    return Slider(
      activeColor: Colors.indigoAccent,
      label: "Tamaño de la imagen",
      divisions: 10,
      value: _valorSlider,
      min:10.0,
      max:400.0,
      onChanged:(_bloquearCheck) ? null: (valor){
        print(valor);
        setState(() {
          _valorSlider = valor;
        });
      },
    );
  }// _crearSlider

  Widget _crearImagen(){
    return Image(
      image: NetworkImage("https://www.cinepremiere.com.mx/wp-content/uploads/2019/03/batman-logo.jpg"),
      width: _valorSlider,
      fit: BoxFit.contain,//se ajusta
    );
  }// _crearImagen

}// SliderPage