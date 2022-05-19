import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/screen/intropage.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/testpage.dart';
// import 'mainpage.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '肌動GO',
        home: const MainPage(),
        routes: {
          TestPage.routeName: (context) => const TestPage(),
          "intro_page": (context) => IntroPage()
        });
  }
}
// 切換視覺頁面按鈕
// child: RaisedButton(
//             child: Text('Test'),
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => PoseDetectorView()));
//             },
//           ),