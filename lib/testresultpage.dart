import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class TestResultPage extends StatefulWidget {
  const TestResultPage({Key? key}) : super(key: key);

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

Widget _Title() {
  Color primaryColor = HexColor("7C9C99");

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '肌動GO',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _ResultTitle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '測試結果',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
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
        child: Text('圖表畫面'),
        alignment: Alignment.center,
      ),
    ],
  );
}

Widget _ResultNumber() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '測試次數：47',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _MaxAngle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '最大彎曲角度：108',
    style: TextStyle(
        color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
  );
}

Widget _EndBtn(BuildContext context) {
  Color primaryColor = HexColor("7C9C99");
  return Container(
    width: MediaQuery.of(context).size.width / 1.5,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        '結束',
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

class _TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 6,
              ),
              _Title(),
              SizedBox(
                height: 25,
              ),
              _ResultTitle(),
              SizedBox(
                height: 10,
              ),
              _ResultChart(context),
              SizedBox(
                height: 10,
              ),
              _ResultNumber(),
              SizedBox(
                height: 10,
              ),
              _MaxAngle(),
              SizedBox(
                height: 30,
              ),
              _EndBtn(context),
            ],
          ),
        ],
      ),
    );
  }
}
