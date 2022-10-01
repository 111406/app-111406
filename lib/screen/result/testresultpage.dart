///測試結果頁

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/common/getxbuilder.dart';
import 'package:sport_app/screen/result/testresult_controller.dart';
import 'package:sport_app/model/record.dart';
import 'package:sport_app/model/target.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/http_request.dart';

var currentState = "up";
var testResultList = <String, dynamic>{};

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
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        '測試結果',
        style: TextStyle(
          color: primaryColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// Widget _resultChart(context, chartData) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Container(
//         decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: MediaQuery.of(context).size.height / 2.5,
//         child: SfCartesianChart(
//           // Initialize category axis
//           primaryXAxis: NumericAxis(
//             interval: 5,
//             minimum: 0,
//             maximum: 30,
//           ),
//           series: <ChartSeries>[
//             // Initialize line series
//             LineSeries<ChartData, double>(
//               dataSource: chartData,
//               xValueMapper: (ChartData data, _) => data.sec,
//               yValueMapper: (ChartData data, _) => data.angle,
//             )
//           ],
//         ),
//         alignment: Alignment.center,
//       ),
//     ],
//   );
// }

Widget _resultNumber(context, times) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 5,
      ),
      const Text(
        '測試次數',
        style: TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 8,
      ),
      Text(
        '$times',
        style: const TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget _resultAnalyze(context, testResult) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 5,
      ),
      const Text(
        '結果分析',
        style: TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 10,
      ),
      Text(
        '$testResult',
        style: const TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget _resultPR(context, pr) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 3.5,
      ),
      const Text(
        'PR值',
        style: TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: MediaQuery.of(context).size.width / 5.3),
      Text(
        '$pr',
        style: const TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget _resultGap(context, difference) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 6,
      ),
      const Text(
        '與上次相差',
        style: TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: MediaQuery.of(context).size.width / 9),
      Text(
        '$difference',
        style: const TextStyle(
          color: primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget _endBtn(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            String userId = prefs.getString("userId")!;

            // 確認是否還有訓練未做完，有的話就不會新增訓練計劃表
            final responseData = await HttpRequest().get("${HttpURL.host}/target/existed/$userId");
            bool checkExisted = responseData["data"];
            if (!checkExisted) {
              List userTodoList = [];
              DateTime now = DateTime.now();
              DateTime startDateTime = now.add(Duration(days: 8 - now.weekday));
              String startDate = DateFormat('yyyyMMdd').format(startDateTime);
              String endDate = DateFormat('yyyyMMdd').format(startDateTime.add(const Duration(days: 28)));
              for (int i = 0; i < 8; i++) {
                DateTime targetDateTime =
                    i % 2 == 0 ? startDateTime.add(Duration(days: 7 * (i ~/ 2))) : startDateTime.add(Duration(days: 3 + 7 * (i ~/ 2)));
                String targetDate = DateFormat('yyyyMMdd').format(targetDateTime);
                // TODO 目前為預設值，做資料分析才能做出完整計畫，待調整
                dynamic userTodo = {
                  "target_date": targetDate,
                  "target_times": [
                    {"times": 15, "set": 2, "total": 30},
                    {"times": 8, "set": 1, "total": 8},
                    {"times": 15, "set": 2, "total": 30}
                  ],
                  "complete": false
                };
                userTodoList.add(userTodo);
              }
              Target target = Target(
                userId,
                startDate,
                endDate,
                userTodoList,
              );
              await HttpRequest().post("${HttpURL.host}/target", jsonEncode(target.toJson()));
            }

            Navigator.pushReplacementNamed(context, Main.routeName);
          },
          child: const Text(
            '結束',
            style: TextStyle(fontSize: 24),
          ),
          style: ElevatedButton.styleFrom(primary: primaryColor),
        ),
      )
    ],
  );
}

Widget _testMode(BuildContext context, TestResultController controller) {
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              currentState = "up";
              controller.setCurrentRecord(currentState, testResultList[currentState]);
            },
            child: const Text("上肢"),
            style: controller.checkCurrentState("up") ? _hasPressedButton() : _hasNotPressedButton(),
          ),
        ),
        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              currentState = "down";
              controller.setCurrentRecord(currentState, testResultList[currentState]);
            },
            child: const Text("下肢"),
            style: controller.checkCurrentState("down") ? _hasPressedButton() : _hasNotPressedButton(),
          ),
        ),
      ],
    ),
  );
}

ButtonStyle _hasPressedButton() {
  return ElevatedButton.styleFrom(
    primary: secondColor,
    elevation: 5,
  );
}

ButtonStyle _hasNotPressedButton() {
  return ElevatedButton.styleFrom(
    primary: thirdColor,
    onPrimary: primaryColor,
    elevation: 5,
  );
}

class TestResultPage extends StatefulWidget {
  const TestResultPage({Key? key}) : super(key: key);
  static const String routeName = "/testresultpage";

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  final controller = Get.put(TestResultController());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Record bicepsTestResult = Record.fromJson(jsonDecode(args['bicepsData']));
    Record quadricepsTestResult = Record.fromJson(jsonDecode(args['quadricepsData']));
    testResultList["up"] = bicepsTestResult;
    testResultList["down"] = quadricepsTestResult;

    controller.setCurrentRecord(currentState, testResultList[currentState]);

    bool isHasDiff = bicepsTestResult.difference == null;

    Get.put<TestResultController>(TestResultController());

    return Scaffold(
      body: SingleChildScrollView(
        child: GetBindWidget(
          bind: controller,
          child: GetBuilder<TestResultController>(
            builder: (controller) => Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 6,
                ),
                _title(),
                const SizedBox(height: 25),
                _resultTitle(),
                const SizedBox(height: 30),
                _testMode(context, controller),
                const SizedBox(height: 15),
                _resultNumber(context, controller.currentRecord.times),
                const SizedBox(height: 15),
                _resultAnalyze(context, controller.currentRecord.testResult),
                const SizedBox(height: 15),
                _resultPR(context, controller.currentRecord.pr),
                const SizedBox(height: 15),
                if (!isHasDiff) _resultGap(context, controller.currentRecord.difference),
                if (!isHasDiff) const SizedBox(height: 30),
                // 顯示角度變化圖表
                // _resultChart(context, chartData),
                // const SizedBox(height: 30),
                _endBtn(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
