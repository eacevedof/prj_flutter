//file:settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_preferencias_usuario/src/widgets/menu_widget.dart';

class SettingsPage extends StatelessWidget {
  
  //propiedad estática
  static final String routeName = "settings";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      drawer: MenuWidget(),
      body: Center(
          child: Text("Ajustes Page"),
        )
    );

  }//build

}//class SettingsPage