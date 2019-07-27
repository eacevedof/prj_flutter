//@file: animated_container_page
import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}// AnimatedContainerPage

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.pink;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Container"),
      ),

      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: _color
          ),
          duration: Duration(seconds: 1), //animación (curves=animación predefinida)
          curve: Curves.fastOutSlowIn, // tipo de transición
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: _cambiarForma,
      ),      
    );
  }// build

  void _cambiarForma(){
    final rnd = Random();

    // detecta cambios en las variables privadas y refresca la pantalla
    setState(() {
      _width = rnd.nextInt(300).toDouble();
      _height = rnd.nextInt(300).toDouble();
      _color = Color.fromRGBO(rnd.nextInt(300),rnd.nextInt(300),rnd.nextInt(300), 1);

      _borderRadius = BorderRadius.circular(rnd.nextInt(100).toDouble());
    });
  }// _cambiarForma

}// _AnimatedContainerPageState