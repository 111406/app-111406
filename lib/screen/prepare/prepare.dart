///二頭肌測試準備頁

import 'package:flutter/material.dart';
import 'package:sport_app/screen/testing/testpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Prepare extends StatefulWidget {
  const Prepare({Key? key}) : super(key: key);
  static const String routeName = "/prepare";

  @override
  State<Prepare> createState() => _PrepareState();
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
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _countNumberTitle() {
  return const Text(
    '下一個動作',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _poseTitle() {
  return const Text(
    '二頭肌彎舉',
    style: TextStyle(
      color: primaryColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _tutorialScreen(BuildContext context) {
  //一般模式 二頭肌教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.05,
        height: MediaQuery.of(context).size.height / 1.8,
        children: [
          Image.network(
            //ZERO
            'https://cdn.discordapp.com/attachments/800700545169883189/1030792104995192872/unknown.png',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://cdn.discordapp.com/attachments/800700545169883189/1030793521780756551/02.png',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://cdn.discordapp.com/attachments/800700545169883189/1030793522183409664/03.png',
            fit: BoxFit.cover,
          ),
        ],
        onPageChanged: (value) {},
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
        Navigator.pushReplacementNamed(context, TestPage.routeName);
      },
      child: const Text('開始', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _PrepareState extends State<Prepare> {
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
}
