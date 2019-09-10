//push_notifications_provider.dart
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initNotifications(){
    //FirebaseMessaging.initializeApp(this);
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token){
      print("FCM TOKEN");
      print(token);
    });
  }


}//class PushNotificationsProvider