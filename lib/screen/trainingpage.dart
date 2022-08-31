import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);
  static const String routeName = "/train";

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

Widget _PoseTitle() {
  return const Text(
    '二頭肌',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _TargetNumberTitle() {
  return const Text(
    '剩餘組數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _TargetNumber() {
  return const Text(
    '2',
    style: TextStyle(
        color: primaryColor, fontSize: 72, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumberTitle() {
  return const Text(
    '剩餘次數',
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
              _PoseTitle(),
              const SizedBox(
                height: 60,
              ),
              _TargetNumberTitle(),
              _TargetNumber(),
              const SizedBox(
                height: 60,
              ),
              _CountNumberTitle(),
              _CountNumber(),
              const SizedBox(
                height: 60,
              ),
              _EndBtn(),
            ],
          ),
        ],
      ),
    );
  }
}
