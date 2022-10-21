import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../enum/training_part.dart';

class TabBarTable extends StatelessWidget {
  const TabBarTable({
    Key? key,
    required this.size,
    required this.todoMap,
    required this.selectedDay,
  }) : super(key: key);

  final Size size;
  final Map todoMap;
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    if (todoMap[DateFormat('yyyyMMdd').format(selectedDay)] == null) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            "本日無預計運動計畫",
            style: TextStyle(
              color: Color.fromARGB(120, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      // 顯示實做完成度
      Map todoList = todoMap[DateFormat('yyyyMMdd').format(selectedDay)];
      final targetTimes = todoList['target_times'] as List;
      final actualTimes = todoList['actual_times'] as List;
      final children = generateActualTimeWidget(actualTimes, targetTimes);
      return SizedBox(
        height: size.height * 0.4,
        child: TabBarView(
          children: children,
        ),
      );
    }
  }
}

Widget upperLimb({
  required targetTimes,
  required actualLeft,
  required actualRight,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
        child: Row(
          children: [
            Text(
              '目標次數：$targetTimes',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularPercentIndicator(
            backgroundColor: const Color.fromARGB(25, 255, 255, 255),
            radius: 60.0,
            lineWidth: 15.0,
            circularStrokeCap: CircularStrokeCap.round,
            percent: actualLeft / targetTimes,
            center: (actualLeft != targetTimes)
                ? Text(
                    "$actualLeft",
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Icon(Icons.check_rounded, color: Colors.white, size: 50.0),
            header: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "左手次數",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            progressColor: Colors.white,
          ),
          const SizedBox(width: 40),
          CircularPercentIndicator(
            backgroundColor: const Color.fromARGB(25, 255, 255, 255),
            radius: 60.0,
            lineWidth: 15.0,
            circularStrokeCap: CircularStrokeCap.round,
            percent: actualRight / targetTimes,
            center: (actualRight != targetTimes)
                ? Text(
                    "$actualRight",
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Icon(Icons.check_rounded, color: Colors.white, size: 50.0),
            header: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "右手次數",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            // footer: const Text("完成"),
            progressColor: Colors.white,
          ),
        ],
      ),
    ],
  );
}

Widget lowerLimb({
  required targetTimes,
  required actualTimes,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
        child: Row(
          children: [
            Text(
              '目標次數：$targetTimes',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularPercentIndicator(
            backgroundColor: const Color.fromARGB(25, 255, 255, 255),
            radius: 60.0,
            lineWidth: 15.0,
            circularStrokeCap: CircularStrokeCap.round,
            percent: actualTimes / targetTimes,
            center: (actualTimes != targetTimes)
                ? Text(
                    "$actualTimes",
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Icon(Icons.check_rounded, color: Colors.white, size: 50.0),
            header: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "訓練次數",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            // footer: const Text("asdsa"),
            progressColor: Colors.white,
          ),
        ],
      ),
    ],
  );
}

List<Widget> generateActualTimeWidget(List actualTimes, List targetTimes) {
  final children = <Widget>[];
  for (final targetTime in targetTimes) {
    TrainingPart part = TrainingPart.parse(targetTime['part']);
    Widget toBeCreatedWidget;
    switch (part) {
      case TrainingPart.biceps:
      case TrainingPart.deltoid:
        final actualLeft = actualTimes.where((element) => element['part'] == part.value && element['hand'] == 'left').first;
        final actualRight = actualTimes.where((element) => element['part'] == part.value && element['hand'] == 'right').first;
        toBeCreatedWidget = upperLimb(
          actualLeft: actualLeft['times'],
          actualRight: actualRight['times'],
          targetTimes: targetTime['total'],
        );
        break;
      default:
        final actualTime = actualTimes.where((element) => element['part'] == part.value).first;
        toBeCreatedWidget = lowerLimb(
          targetTimes: targetTime['total'],
          actualTimes: actualTime['times'],
        );
        break;
    }
    children.add(toBeCreatedWidget);
  }
  return children;
}
