import 'package:firebase_messaging/firebase_messaging.dart';

import 'app_config.dart';

class AppUtils {
  static Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken(vapidKey: AppConfig.FCM_VAPID_KEY);
  }
}
