import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/testpage.dart';
import 'package:sport_app/test/pose_detector_view.dart';
// import 'mainpage.dart';

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
        MainPage.routeName: (context) => const MainPage(),
        // IntroPage.routeName: (context) => const IntroPage(),
        TestPage.routeName: (context) => const TestPage(),
        PoseDetectorView.routeName: (context) => const PoseDetectorView(),
      },
    );
  }
}
