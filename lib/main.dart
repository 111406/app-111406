import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/screen/choosing_page/choosing_page.dart';
import 'package:sport_app/screen/forgotpassword.dart';
import 'package:sport_app/screen/intropage.dart';
import 'package:sport_app/screen/loadingpage.dart';
import 'package:sport_app/screen/loginpage.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/registerpage.dart';
import 'package:sport_app/screen/registerpage02.dart';
import 'package:sport_app/screen/testpage.dart';
import 'package:sport_app/screen/testpage2.dart';
import 'package:sport_app/screen/testresultpage.dart';
import 'package:sport_app/screen/user_info_page/user_info_edit_page.dart';
import 'package:sport_app/screen/user_info_page/user_info_page.dart';
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

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    // ignore: avoid_print
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(const MyApp());
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '肌動GO',
      home: const Main(),
      //initialRoute: MainPage.routeName,
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
        MainPage.routeName: (context) => const MainPage(),
        IntroPage.routeName: (context) => const IntroPage(),
        TestPage.routeName: (context) => const TestPage(),
        TestPage2.routeName: (context) => const TestPage2(),
        PoseDetectorView.routeName: (context) => const PoseDetectorView(),
        TestResultPage.routeName: (context) => const TestResultPage(),
        TrainingPage.routeName: (context) => const TrainingPage(),
        WarmupPage.routeName: (context) => const WarmupPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
