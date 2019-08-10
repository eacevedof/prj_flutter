//scroll_page.dart
import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView(
        //esto permite hacer scroll de arriba hacia abajo
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _get_pagina1_wg(),
          _get_pagina2_wg(),
        ],
      )
    );

  }// build

  Widget _get_pagina1_wg() {
    return Center(
      child: Text("Pagina1"),
    );
  }

  Widget _get_pagina2_wg() {
    return Center(
      child: Text("Pagina 2"),
    );
  }

}// ScrollPage