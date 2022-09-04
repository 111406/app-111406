import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/change_password/change_password.dart';
import 'package:sport_app/screen/choosing/choosing.dart';
import 'package:sport_app/screen/forgot_password/forgotpassword.dart';
import 'package:sport_app/screen/intropage.dart';
import 'package:sport_app/screen/loadingpage.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/regitster/register.dart';
import 'package:sport_app/screen/regitster/register_next.dart';
import 'package:sport_app/screen/testpage.dart';
import 'package:sport_app/screen/testpage2.dart';
import 'package:sport_app/screen/testresultpage.dart';
import 'package:sport_app/screen/user_info/user_info.dart';
import 'package:sport_app/screen/user_info/user_info_edit.dart';
import 'package:sport_app/test/pose_detector_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sport_app/screen/prepare.dart';
import 'package:sport_app/screen/prepare2.dart';
import 'package:sport_app/screen/warmuppage.dart';
import 'package:sport_app/screen/trainingpage.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId') ?? '';
  String token = prefs.getString('token') ?? '';

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    // ignore: avoid_print
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp((userId != '' && token != '')
      ? MyApp(userId: userId, token: token)
      : const MyApp(userId: '', token: ''));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
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
      title: '肌動GO',
      home: const LoginPage(),
      //initialRoute: MainPage.routeName,
      initialRoute:
          (userId != '' && token != '') ? Main.routeName : LoginPage.routeName,
      routes: {
        Main.routeName: (context) => const Main(),
        ChoosingPage.routeName: (context) => const ChoosingPage(),
        UserInfoPage.routeName: (context) => const UserInfoPage(),
        UserInfoEditPage.routeName: (context) => const UserInfoEditPage(),
        ForgotPassword.routeName: (context) => const ForgotPassword(),
        LoadingPage.routeName: (context) => const LoadingPage(),
        Prepare.routeName: (context) => const Prepare(),
        Prepare2.routeName: (context) => const Prepare2(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        RegisterPage02.routeName: (context) => const RegisterPage02(),
        IntroPage.routeName: (context) => const IntroPage(),
        TestPage.routeName: (context) => const TestPage(),
        TestPage2.routeName: (context) => const TestPage2(),
        PoseDetectorView.routeName: (context) => const PoseDetectorView(),
        TestResultPage.routeName: (context) => const TestResultPage(),
        TrainingPage.routeName: (context) => const TrainingPage(),
        WarmupPage.routeName: (context) => const WarmupPage(),
        ChangePassword.routeName: (context) => const ChangePassword(),
      },
      builder: EasyLoading.init(),
    );
  }
}
