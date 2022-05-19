import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

Widget _Title() {
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

Widget _SecondLeftTitle() {
  return const Text(
    '剩餘秒數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _SecondLeft() {
  return const Text(
    '47',
    style: TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumberTitle() {
  return const Text(
    '次數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumber() {
  return const Text(
    '13',
    style: TextStyle(
        color: primaryColor, fontSize: 72, fontWeight: FontWeight.bold),
  );
}

Widget _Angle() {
  return const Text(
    '3',
    style: TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _AngleTitle() {
  return const Text(
    '角度',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _EndBtn() {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {},
      child: const Text(
        '長按結束',
        style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _TrainingPageState extends State<TrainingPage> {
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
              const SizedBox(
                height: 25,
              ),
              _SecondLeftTitle(),
              const SizedBox(
                height: 30,
              ),
              _SecondLeft(),
              const SizedBox(
                height: 60,
              ),
              _CountNumberTitle(),
              _CountNumber(),
              const SizedBox(
                height: 60,
              ),
              _Angle(),
              _AngleTitle(),
              const SizedBox(
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
