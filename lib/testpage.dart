import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

Widget _Title() {
  Color primaryColor = HexColor("7C9C99");

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
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

Widget _SecondLeftTitle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '剩餘秒數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _SecondLeft() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '30',
    style: TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumberTitle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '次數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumber() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '3',
    style: TextStyle(
        color: primaryColor, fontSize: 72, fontWeight: FontWeight.bold),
  );
}

Widget _Angle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '3',
    style: TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _AngleTitle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '角度',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _EndBtn() {
  Color primaryColor = HexColor("7C9C99");
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {},
      child: Text(
        '長按結束',
        style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _TestPageState extends State<TestPage> {
  Color primaryColor = HexColor("7C9C99");
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
              _SecondLeftTitle(),
              SizedBox(
                height: 30,
              ),
              _SecondLeft(),
              SizedBox(
                height: 60,
              ),
              _CountNumberTitle(),
              _CountNumber(),
              SizedBox(
                height: 60,
              ),
              _Angle(),
              _AngleTitle(),
              SizedBox(
                height: 50,
              ),
              _EndBtn(),
            ],
          ),
        ],
      ),
    );
  }
}
