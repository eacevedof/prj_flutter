//usuario_provider.dart
//https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  //se obtiene de: https://console.firebase.google.com/project/fir-flutter-db876/settings/general/
  final String _firebaseToken = "AIzaSyBs5xvUOzSE5aIInVBhG_DgFDRuG8Piq-4";

  Future get_nuevo_usuario_async(String email, String password) async {
    final authData = {
      "email"             : email,
      "password"          : password,
      "returnSecureToken" : true,
    };

    final url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken";
    final resp = await http.post(
        url,
        body: json.encode(authData)
      );
    
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

  }//get_nuevo_usuario_async

}//class UsuarioProvider