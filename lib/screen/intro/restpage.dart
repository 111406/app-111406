import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sport_app/screen/training/trainingpage.dart';
import 'package:sport_app/theme/color.dart';
import '../components/button.dart';

var _displayTimer = 60;
late Timer timer;

class RestPage extends StatefulWidget {
  const RestPage({Key? key}) : super(key: key);
  static const String routeName = "/rest";

  @override
  State<RestPage> createState() => _RestPageState();
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
      )
    ],
  );
}

Widget _secondLeftTitle() {
  return const Text(
    '剩餘秒數',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _secondLeft(int timer) {
  return Text(
    timer.toString(),
    style: const TextStyle(
      color: primaryColor,
      fontSize: 42,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _countNumberTitle() {
  return const Text(
    '休息時間',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _warmUpGit() {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/icon/rest.gif',
    image: 'https://c.tenor.com/-U7dV-vMdOEAAAAC/%E4%BC%91%E6%81%AF%E4%B8%80%E4%B8%8B-corgi.gif',
  );
}

class _RestPageState extends State<RestPage> {
  late final int tobeMinused = 60;

  @override
  void initState() {
    super.initState();
    _setTimerEvent();
  }

  @override
  void dispose() {
    timer.cancel();
    _displayTimer = 60;
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
                _warmUpGit(),
                const SizedBox(height: 30),
                _secondLeftTitle(),
                const SizedBox(height: 30),
                _secondLeft(_displayTimer),
                const SizedBox(height: 35),
                endBtn(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  var period = const Duration(seconds: 1);

  ///設定倒數計時器
  void _setTimerEvent() {
    timer = Timer.periodic(period, (_timer) async {
      setState(() {
        _displayTimer = tobeMinused - _timer.tick;
      });
      if (_displayTimer == 0) {
        _timer.cancel();
        Navigator.pushReplacementNamed(context, TrainingPage.routeName);
      }
    });
  }
}
