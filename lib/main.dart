import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/change_password/change_password.dart';
import 'package:sport_app/screen/choosing/choosing.dart';
import 'package:sport_app/screen/choosing/choosinghand.dart';
import 'package:sport_app/screen/forgot_password/forgotpassword.dart';
import 'package:sport_app/screen/forgot_password/forgotpassword02.dart';
import 'package:sport_app/screen/intro/intropage.dart';
import 'package:sport_app/screen/intro/prepare/prepare.dart';
import 'package:sport_app/screen/intro/prepare/prepare2.dart';
import 'package:sport_app/screen/intro/warmup/warmuppage.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/intro/training_intropage.dart';
import 'package:sport_app/screen/manual/manual.dart';
import 'package:sport_app/screen/regitster/register.dart';
import 'package:sport_app/screen/intro/restpage.dart';
import 'package:sport_app/screen/testing/testpage.dart';
import 'package:sport_app/screen/testing/testpage2.dart';
import 'package:sport_app/screen/result/testresultpage.dart';
import 'package:sport_app/screen/training/trainingpage.dart';
import 'package:sport_app/screen/user_info/user_info.dart';
import 'package:sport_app/screen/user_info/user_info_edit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sport_app/utils/app_config.dart';
import 'package:sport_app/utils/http_request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'model/user_todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _fcmInit();

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  configLoading();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId') ?? '';
  String token = prefs.getString('token') ?? '';

  if (userId != '' && token != '') loadTrainingData(prefs, userId, token);

  runApp(
    (userId != '' && token != '') ? MyApp(userId: userId, token: token) : const MyApp(userId: '', token: ''),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

Future<void> loadTrainingData(SharedPreferences prefs, String userId, String token) async {
  prefs.setBool("loading", true);
  bool checkComplete = true;
  List checkCompleteList = [];
  await prefs.remove("trainingState");
  final todoList = <UserTodo>[];
  final todoMap = {};
  await HttpRequest.get('${HttpURL.host}/target/$userId').then((response) async {
    final dataList = response['data'] as List;
    if (dataList.isNotEmpty) {
      // 有本周訓練資料
      for (var data in response['data']) {
        var todo = UserTodo.fromJson(data);
        checkCompleteList.add(todo.complete);

        todoMap[todo.targetDate] = todo;
        todoList.add(todo);
      }
      checkComplete = checkCompleteList.contains(false);

      await prefs.setString("todoMap", json.encode(todoMap));

      if (checkComplete) {
        prefs.setString("userTodo", json.encode(todoList.firstWhere((element) => !element.complete)));
      }
    } else {
      // 檢查是不是剛做完檢測，因為不會馬上指派任務
      await HttpRequest.get('${HttpURL.host}/target/started/$userId').then((response) {
        final isHadTarget = response['data'];
        prefs.remove("todoList");
        prefs.remove("userTodo");
        if (isHadTarget) {
          // 如果是剛檢測完會跑到這
          prefs.setString("trainingState", AppConfig.WAITING_TRAINING);
        } else {
          // 代表還沒做檢測
          prefs.setString("trainingState", AppConfig.CANNOT_TRAINING);
        }
      });
    }
  });
  if (!checkComplete) {
    // 進到這裡表示本周任務已完成
    prefs.setString("trainingState", AppConfig.TRAINING_FINISH);
  }
  
  prefs.setBool("loading", false);
}

class MyApp extends StatelessWidget {
  final String userId;
  final String token;

  const MyApp({
    Key? key,
    required this.userId,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'TW'),
      ],
      title: '肌動GO',
      home: const LoginPage(),
      initialRoute: (userId != '' && token != '') ? Main.routeName : LoginPage.routeName,
      routes: {
        Main.routeName: (context) => const Main(),
        Manual.routeName: (context) => const Manual(),
        ChoosingPage.routeName: (context) => const ChoosingPage(),
        UserInfoPage.routeName: (context) => const UserInfoPage(),
        UserInfoEditPage.routeName: (context) => const UserInfoEditPage(),
        ForgotPassword.routeName: (context) => const ForgotPassword(),
        ForgotPassword02.routeName: (context) => const ForgotPassword02(),
        Prepare.routeName: (context) => const Prepare(),
        Prepare2.routeName: (context) => const Prepare2(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        IntroPage.routeName: (context) => const IntroPage(),
        TestPage.routeName: (context) => const TestPage(),
        TestPage2.routeName: (context) => const TestPage2(),
        TestResultPage.routeName: (context) => const TestResultPage(),
        TrainingPage.routeName: (context) => const TrainingPage(),
        WarmupPage.routeName: (context) => const WarmupPage(),
        ChangePassword.routeName: (context) => const ChangePassword(),
        TrainingIntroPage.routeName: (context) => const TrainingIntroPage(),
        ChoosingHandPage.routeName: (context) => const ChoosingHandPage(),
        RestPage.routeName: (context) => const RestPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}

/// init firebase and cloud messaging
Future<void> _fcmInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //iOS啟用前台通知
  if (Platform.isIOS) {
    // Required to display a heads up notification
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen(showFlutterNotification);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  debugPrint("Handling a background message: ${message.messageId}");
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  final title = message.data['title'];
  final body = message.data['body'];
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'app_icon',
        ),
      ),
    );
  } else if (title != null && body != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'app_icon',
        ),
      ),
    );
  }
}
