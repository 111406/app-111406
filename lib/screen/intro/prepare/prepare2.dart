///座椅深蹲測試準備頁

import 'package:flutter/material.dart';
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
        width: MediaQuery.of(context).size.width / 1.05,
        height: MediaQuery.of(context).size.height / 1.8,
        children: [
          Image.network(
            'https://cdn.discordapp.com/attachments/1033254616411951154/1033254876332961833/0new.png',
            fit: BoxFit.contain,
          ),
          Image.network(
            'https://cdn.discordapp.com/attachments/1033254616411951154/1033254876660109385/01new.png',
            fit: BoxFit.contain,
          ),
          Image.network(
            'https://cdn.discordapp.com/attachments/1033254616411951154/1033254877075357816/02new.png',
            fit: BoxFit.contain,
          ),
          Image.network(
            'https://cdn.discordapp.com/attachments/1033254616411951154/1033254877486395393/03new.png',
            fit: BoxFit.contain,
          ),
          Image.network(
            'https://cdn.discordapp.com/attachments/1033254616411951154/1033254877855502396/04new.png',
            fit: BoxFit.contain,
          ),
        ],
        onPageChanged: (value) {},
        autoPlayInterval: 300000,
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
        Navigator.pushReplacementNamed(context, TestPage2.routeName);
      },
      child: const Text('開始', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _PrepareState2 extends State<Prepare2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
      ),
    );
  }
}
