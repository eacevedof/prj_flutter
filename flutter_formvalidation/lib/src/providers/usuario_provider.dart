//usuario_provider.dart
//https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  //se obtiene de: https://console.firebase.google.com/project/fir-flutter-db876/settings/general/
  final String _firebaseToken = "AIzaSyBs5xvUOzSE5aIInVBhG_DgFDRuG8Piq-4";

  //este método crea el usuario en: https://console.firebase.google.com/project/fir-flutter-db876/authentication/users
  Future<Map<String, dynamic>> get_nuevo_usuario_async(String email, String password) async {
    final authData = {
      "email"             : email,
      "password"          : password,
      "returnSecureToken" : true,
    };

    final url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken";
    //print("get_nuevo_usuario_async url: "+url);
    final resp = await http.post(
        url,
        body: json.encode(authData)
    );
    
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if(decodedResp.containsKey("idToken")){
      return {"ok":true, "token":decodedResp["idToken"]};
    }
    return {"ok":false, "token":decodedResp["error"]["message"]};

  }//get_nuevo_usuario_async

  Future<Map<String, dynamic>> get_login_async(String email, String password) async{
    final authData = {
      "email"             : email,
      "password"          : password,
      "returnSecureToken" : true,
    };

    final url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken";
    //print("get_nuevo_usuario_async url: "+url);
    final resp = await http.post(
        url,
        body: json.encode(authData)
    );
    
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if(decodedResp.containsKey("idToken")){
      return {"ok":true, "token":decodedResp["idToken"]};
    }
    return {"ok":false, "token":decodedResp["error"]["message"]};
  }

}//class UsuarioProvider