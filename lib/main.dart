import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/screen/forgotpassword.dart';
import 'package:sport_app/screen/intropage.dart';
import 'package:sport_app/screen/loadingpage.dart';
import 'package:sport_app/screen/loginpage.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/registerpage.dart';
import 'package:sport_app/screen/registerpage02.dart';
import 'package:sport_app/screen/testpage.dart';
import 'package:sport_app/screen/testresultpage.dart';
import 'package:sport_app/test/pose_detector_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    // ignore: avoid_print
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '肌動GO',
      // home: const MainPage(),
      initialRoute: MainPage.routeName,
      routes: {
        ForgotPassword.routeName: (context) => const ForgotPassword(),
        LoadingPage.routeName: (context) => const LoadingPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        RegisterPage02.routeName: (context) => const RegisterPage02(),
        MainPage.routeName: (context) => const MainPage(),
        IntroPage.routeName: (context) => const IntroPage(),
        TestPage.routeName: (context) => const TestPage(),
        PoseDetectorView.routeName: (context) => const PoseDetectorView(),
        TestResultPage.routeName: (context) => const TestResultPage(),
      },
    );
  }
}
