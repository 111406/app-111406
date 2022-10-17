///主頁分頁

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/enum/training_part.dart';
import 'package:sport_app/screen/choosing/choosing.dart';
import 'package:sport_app/screen/manual/intropage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/app_config.dart';
import 'package:sport_app/utils/http_request.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String todoMapString = '{}';
  Map todoMap = {};

  final kToday = DateTime.now();
  late final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day - 7);
  late final kLastDay = DateTime(kToday.year, kToday.month, kToday.day + 7);
  CalendarFormat _calendarFormat = CalendarFormat.week;
  Map<CalendarFormat, String> availableCalendarFormats = const {
    // CalendarFormat.month: 'Month',
    CalendarFormat.week: 'Week'
  };
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = _focusedDay;

  @override
  initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoMapString = prefs.getString('todoMap') ?? "{}";
      todoMap = jsonDecode(todoMapString);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Tab> myTabs = <Tab>[
      const Tab(text: '二頭肌'),
      const Tab(text: '三角肌'),
      const Tab(text: '滑牆深蹲'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.63,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.57,
                    decoration: const BoxDecoration(
                        color: secondColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "本週運動計畫",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TableCalendar(
                          headerStyle: headerStyle(),
                          calendarStyle: calenderStyle(),
                          daysOfWeekStyle: daysOfWeekStyle(),
                          daysOfWeekHeight: 20,
                          locale: 'zh_TW',
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          focusedDay: _focusedDay,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarFormat: _calendarFormat,
                          availableCalendarFormats: availableCalendarFormats,
                          // availableGestures: AvailableGestures.all,
                          onDaySelected: _onDaySelected,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onPageChanged: (focusedDay) =>
                              _focusedDay = focusedDay,
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              setState(() => _calendarFormat = format);
                            }
                          },
                          // eventLoader: (day) {
                          //   if (day.weekday == DateTime.thursday ||
                          //       day.weekday == DateTime.monday) {
                          //     return [DateTime];
                          //   }
                          //   return [];
                          // },
                        ),
                        TabBar(
                          tabs: myTabs,
                          indicatorColor: Colors.white,
                          labelStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TabBarTable(
                          size: size,
                          selectedDay: _selectedDay,
                          todoMap: todoMap,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final trainingState =
                              prefs.getString("trainingState");
                          switch (trainingState) {
                            case AppConfig.CANNOT_TRAINING:
                              showAlertDialog(context,
                                  message: "請先進行運動測試再回來做訓練喔！");
                              break;
                            case AppConfig.TRAINING_FINISH:
                              showAlertDialog(context,
                                  message: "您目前的訓練已完成，請等候下次的新任務喔！");
                              break;
                            case AppConfig.WAITING_TRAINING:
                              showAlertDialog(context,
                                  message: "恭喜您完成測驗，請等待至隔周即可開始任務！");
                              break;
                            default:
                              Navigator.pushReplacementNamed(
                                  context, ChoosingPage.routeName);
                          }
                        },
                        child: Ink(child: trainingBtn()),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('introScreen', 1);
                  Navigator.pushReplacementNamed(context, IntroPage.routeName);
                },
                child: Ink(child: testingBtn()),
              ),
            )
          ],
        ),
      ),
    );
  }

  DaysOfWeekStyle daysOfWeekStyle() => const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        weekendStyle: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10),
        // ),
      );

  HeaderStyle headerStyle() => HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        // titleCentered: true,
        headerPadding: const EdgeInsets.only(left: 20),
        formatButtonShowsNext: false,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        formatButtonTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      );

  CalendarStyle calenderStyle() => const CalendarStyle(
        // outsideDaysVisible: true,
        isTodayHighlighted: false,
        defaultTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        todayTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        todayDecoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        selectedDecoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        outsideTextStyle: TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 173, 173, 173),
          fontWeight: FontWeight.bold,
        ),
      );

  Container trainingBtn() {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(left: 15, right: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(children: [
              SizedBox(
                height: 75,
                width: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/icon/training.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '訓練',
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: const Color(0x50292D32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.play_arrow_rounded,
                size: 30, color: Colors.black),
          )
        ],
      ),
    );
  }

  Container testingBtn() {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(left: 15, right: 25),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset('assets/icon/testing.png'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    '開始測試',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: const Color(0x50292D32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: false,
      elevation: 0,
      title: const Text('肌動Go'),
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset('assets/icon/logo_white.png'),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.notifications_none),
      //   ),
      // ],
    );
  }

  Future<void> addUserTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    String targetDate = DateFormat('yyyyMMdd').format(DateTime.now());
    dynamic userTodo = {
      "target_date": targetDate,
      "target_times": [
        {"times": 15, "set": 2, "total": 30},
        {"times": 8, "set": 1, "total": 8},
        {"times": 15, "set": 2, "total": 30}
      ],
      "complete": false
    };
    try {
      await HttpRequest.post(
          '${HttpURL.host}/target/add/todo/$userId', jsonEncode(userTodo));
      Navigator.pushReplacementNamed(context, ChoosingPage.routeName);
    } catch (e) {
      Navigator.pop(context);
      final errorMessage = e.toString().split(" ")[1];
      showAlertDialog(context, message: errorMessage);
    }
  }
}

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
    if (todoMap.isEmpty) {
      return SizedBox(
        height: size.height * 0.2,
        child: const Center(
          child: Text(
            "載入中...",
            style: TextStyle(
              color: Color.fromARGB(120, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    if (todoMap[DateFormat('yyyyMMdd').format(selectedDay)] == null) {
      return SizedBox(
        height: size.height * 0.2,
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
      Map todoList = todoMap[DateFormat('yyyyMMdd').format(selectedDay)];
      var targetTimes = todoList['target_times'];
      var actualTimes = todoList['actual_times'];
      return SizedBox(
        height: size.height * 0.4,
        child: TabBarView(
          children: <Widget>[
            // biceps
            upperLimb(
              actualLeft: actualTimes[TrainingPart.biceps.value]['left']
                  ['times'],
              actualRight: actualTimes[TrainingPart.biceps.value]['right']
                  ['times'],
              targetTimes: targetTimes[TrainingPart.biceps.value]['total'],
            ),
            //deltoid
            upperLimb(
              actualLeft: actualTimes[TrainingPart.deltoid.value]['left']
                  ['times'],
              actualRight: actualTimes[TrainingPart.deltoid.value]['right']
                  ['times'],
              targetTimes: targetTimes[TrainingPart.deltoid.value]['total'],
            ),
            lowerLimb(
                targetTimes: targetTimes[TrainingPart.quadriceps.value]
                    ['total'],
                actualTimes: actualTimes[TrainingPart.quadriceps.value]
                    ['times']),
          ],
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
                : const Icon(Icons.check_rounded,
                    color: Colors.white, size: 50.0),
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
                : const Icon(Icons.check_rounded,
                    color: Colors.white, size: 50.0),
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
                : const Icon(Icons.check_rounded,
                    color: Colors.white, size: 50.0),
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
