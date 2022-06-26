import 'package:flutter/material.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/theme/color.dart';

class TestResultPage extends StatefulWidget {
  const TestResultPage({Key? key}) : super(key: key);
  static const String routeName = "/testresultpage";
  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

Widget _Title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        '肌動GO',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _ResultTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      const Text(
        '測試結果',
        style: TextStyle(
            color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _ResultChart(BuildContext context) {
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

Widget _ResultNumber(context, times) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 5,
      ),
      const Text(
        '測試次數',
        style: TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 8,
      ),
      Text(
        '$times',
        style: TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _ResultAnalyze(context, testResult) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 5,
      ),
      const Text(
        '結果分析',
        style: TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 10,
      ),
      Text(
        '$testResult',
        style: const TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _ResultPR(context, pr) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 3.5,
      ),
      const Text(
        'PR值',
        style: TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: MediaQuery.of(context).size.width / 5.3),
      Text(
        '$pr',
        style: const TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _ResultGap(context, difference) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 6,
      ),
      const Text(
        '與上次相差',
        style: TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: MediaQuery.of(context).size.width / 9),
      Text(
        '$difference',
        style: const TextStyle(
            color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _MaxAngle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        '最大角度',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget _EndBtn(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainPage.routeName);
          },
          child: const Text(
            '結束',
            style: TextStyle(fontSize: 24),
          ),
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
          ),
        ),
      )
    ],
  );
}

class _TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    dynamic analyzeData = arguments["data"];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 6,
            ),
            _Title(),
            const SizedBox(
              height: 25,
            ),
            _ResultTitle(),
            const SizedBox(
              height: 30,
            ),
            _ResultNumber(context, analyzeData["times"]),
            const SizedBox(
              height: 15,
            ),
            _ResultAnalyze(context, analyzeData["test_result"]),
            const SizedBox(
              height: 15,
            ),
            _ResultPR(context, analyzeData["pr"]),
            const SizedBox(
              height: 15,
            ),
            _ResultGap(context, analyzeData["difference"].round()),
            const SizedBox(
              height: 30,
            ),
            _ResultChart(context),
            const SizedBox(
              height: 30,
            ),
            _EndBtn(context),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
