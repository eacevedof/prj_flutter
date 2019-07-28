//@file: slider_page.dart
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}// SliderPage

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100.0;

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
            //_crearImagen(),
            Expanded(child: _crearImagen()),
          ],
        )
      ),
    );
  }// build

  Widget _crearSlider(){
    return Slider(
      activeColor: Colors.indigoAccent,
      label: "Tamaño de la imagen",
      divisions: 10,
      value: _valorSlider,
      min:10.0,
      max:400.0,
      onChanged: (valor){
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