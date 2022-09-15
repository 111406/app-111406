import 'package:flutter/material.dart';
import 'package:sport_app/screen/trainingpage.dart';
import 'package:sport_app/theme/color.dart';

class TrainingResultPage extends StatefulWidget {
  const TrainingResultPage({Key? key}) : super(key: key);
  static const String routeName = "/trainresult";
  @override
  State<TrainingResultPage> createState() => _TrainingResultPageState();
}

Widget _title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        '肌動GO',
        style: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _resultTitle() {
  return const Text(
    '測試結果',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _resultChart(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        child: const Text('圖表畫面'),
        alignment: Alignment.center,
      ),
    ],
  );
}

Widget _resultNumber() {
  return const Text(
    '測試次數: 47',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _endBtn(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.5,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, TrainingPage.routeName);
      },
      child: const Text('結束', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _TrainingResultPageState extends State<TrainingResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 6),
              _title(),
              const SizedBox(height: 25),
              _resultTitle(),
              const SizedBox(height: 10),
              _resultChart(context),
              const SizedBox(height: 10),
              _resultNumber(),
              const SizedBox(height: 50),
              _endBtn(context),
            ],
          ),
        ],
      ),
    );
  }
}
