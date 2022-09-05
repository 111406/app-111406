import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:sport_app/model/chart_data.dart';
import 'package:sport_app/screen/testing/testpage2.dart';
import 'package:sport_app/theme/color.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Prepare2 extends StatefulWidget {
  const Prepare2({Key? key}) : super(key: key);
  static const String routeName = "/prepare2";

  @override
  State<Prepare2> createState() => _PrepareState2();
}

Widget _title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Opacity(
        opacity: 0.5,
        child: Text(
          '肌動GO',
          style: TextStyle(
              color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Widget _countNumberTitle() {
  return const Text(
    '下一個動作',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _poseTitle() {
  return const Text(
    '座椅深蹲',
    style: TextStyle(
        color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
  );
}

Widget _tutorialScreen(BuildContext context) {
  //一般模式 深蹲教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        children: [
          Image.network(
            'https://img.edh.tw/c1/1/734/22770752080_b243f771c7.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img.edh.tw/c2/6/5748/22770749660_e00feb3e74.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img.edh.tw/c1/1/734/22770752080_b243f771c7.jpg',
            fit: BoxFit.cover,
          ),
        ],
        onPageChanged: (value) {
          print('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    ],
  );
}

Widget _startBtn(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.5,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, TestPage2.routeName);
      },
      child: const Text('開始', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _PrepareState2 extends State<Prepare2> {
  FlutterTts flutterTts = FlutterTts();
  final List<ChartData> _angleList = [];
  late StreamSubscription<AccelerometerEvent> subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 6),
              _title(),
              const SizedBox(height: 20),
              _countNumberTitle(),
              const SizedBox(height: 30),
              _poseTitle(),
              const SizedBox(height: 30),
              // _WarmUpGit(),
              _tutorialScreen(context),
              const SizedBox(height: 30),
              _startBtn(context),
            ],
          ),
        ],
      ),
    );
  }

  ///設置加速度器更新時間

  var period = const Duration(seconds: 1);

  ///設定倒數計時器

}
