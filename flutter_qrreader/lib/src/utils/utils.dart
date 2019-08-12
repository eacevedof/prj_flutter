//utils.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_qrreader/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrir_scan(BuildContext context, ScanModel oScanModel) async {

  if(oScanModel.tipo == "http")
  {
    if (await canLaunch(oScanModel.valor)){
      await launch(oScanModel.valor);
    }
    else{
      throw "could not launch ${ oScanModel.valor }";
    }
  }
  else
  {
    Navigator.pushNamed(context, "mapa", arguments: oScanModel);
  }

}
