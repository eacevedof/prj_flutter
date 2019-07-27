//@file: routes.dart
import 'package:flutter/material.dart';
import 'package:flutter_componentes/src/pages/alert_page.dart';
import 'package:flutter_componentes/src/pages/animated_container_page.dart';
import 'package:flutter_componentes/src/pages/avatar_page.dart';
import 'package:flutter_componentes/src/pages/card_page.dart';
import 'package:flutter_componentes/src/pages/home_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "/"     : ( BuildContext context) => HomePage(),
    "alert" : ( BuildContext context) => AlertPage(),
    "avatar": ( BuildContext context) => AvatarPage(),
    "card"  : ( BuildContext context) => CardPage(),
    "animatedContainer"  : ( BuildContext context) => AnimatedContainerPage(),
  };
}// getApplicationRoutes


/*
una forma puede ser esta:

final rutas = <String, WidgetBuilder>{
  "/"     : ( BuildContext context) => HomePage(),
  "alert" : ( BuildContext context) => AlertPage(),
  "avatar": ( BuildContext context) => AvatarPage(),
};
*/