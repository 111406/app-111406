///主頁分頁

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/choosing/choosing.dart';
import 'package:sport_app/screen/manual/intropage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/app_config.dart';
import 'package:sport_app/utils/http_request.dart';
import 'package:table_calendar/table_calendar.dart';

import 'tabbar_table.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Map todoMap = {};
  // String todoMapString = '{}';
  late Future<String> todoMapString;
  var _ethsum = '載入中';

  final kToday = DateTime.now();
  // late final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day - 7);
  // late final kLastDay = DateTime(kToday.year, kToday.month, kToday.day + 7);
  late final kFirstDay = kToday.subtract(Duration(days: kToday.weekday - 1));
  late final kLastDay = kToday.add(Duration(days: DateTime.daysPerWeek - kToday.weekday));
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

  Future<void> _loadPrefs() async {
    todoMapString = _prefs.then((SharedPreferences pref) {
      return pref.getString('todoMap') ?? '{}';
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoMap = jsonDecode(prefs.getString('todoMap') ?? "{}");
      _ethsum = prefs.getString("ethsum") ?? "";
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
                        bottomRight: Radius.circular(40),
                      ),
                    ),
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
                          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                          onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              setState(() => _calendarFormat = format);
                            }
                          },
                          eventLoader: (day) {
                            if (todoMap.keys.contains(DateFormat('yyyyMMdd').format(day))) {
                              return [1];
                            }
                            return [];
                          },
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
                        FutureBuilder<String>(
                          future: todoMapString,
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const CircularProgressIndicator();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  jsonDecode(snapshot.data.toString());
                                  return SizedBox(
                                    height: size.height * 0.32,
                                    child: SingleChildScrollView(
                                      child: TabBarTable(
                                        size: size,
                                        selectedDay: _selectedDay,
                                        todoMap: jsonDecode(snapshot.data.toString()),
                                      ),
                                    ),
                                  );
                                }
                            }
                          },
                        ),
                        // SizedBox(
                        //   height: size.height * 0.32,
                        //   child: SingleChildScrollView(
                        //     child: TabBarTable(
                        //       size: size,
                        //       selectedDay: _selectedDay,
                        //       todoMap: todoMap,
                        //     ),
                        //   ),
                        // ),
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
                          final trainingState = prefs.getString("trainingState");
                          switch (trainingState) {
                            case AppConfig.CANNOT_TRAINING:
                              showAlertDialog(context, message: "請先進行運動測試再回來做訓練喔！");
                              break;
                            case AppConfig.TRAINING_FINISH:
                              showCheckDialog(context, message: "您目前的訓練已完成，是否要建立新的訓練？", func: addUserTodo);
                              break;
                            case AppConfig.WAITING_TRAINING:
                              showAlertDialog(context, message: "恭喜您完成測驗，請等待至隔周即可開始任務！");
                              break;
                            default:
                              Navigator.pushReplacementNamed(context, ChoosingPage.routeName);
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
        outsideDaysVisible: true,
        // isTodayHighlighted: false,
        defaultTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        todayTextStyle: TextStyle(
          fontSize: 24,
          color: Color.fromARGB(255, 232, 93, 102),
          fontWeight: FontWeight.bold,
        ),
        todayDecoration: BoxDecoration(
          // color: ,
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
        markerSize: 6,
        markerMargin: EdgeInsets.symmetric(horizontal: 2),
        markerDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
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
            child: const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.black),
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
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset('assets/icon/logo_white.png'),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              const Icon(Icons.copyright_sharp),
              Text(
                // "：$_ethsum",
                "代幣：$_ethsum",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> addUserTodo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("trainingState");
    final userId = prefs.getString("userId");
    String targetDate = DateFormat('yyyyMMdd').format(DateTime.now());
    try {
      final responseData = await HttpRequest.patch('${HttpURL.host}/target/add/todo/$userId/$targetDate', null);
      prefs.setString("userTodo", jsonEncode(responseData['data']));

      Map todoMap = jsonDecode(prefs.getString("todoMap")!);
      todoMap[targetDate] = responseData['data'];
      prefs.setString("todoMap", jsonEncode(todoMap));
      Navigator.pushReplacementNamed(context, ChoosingPage.routeName);
    } catch (e) {
      Navigator.pop(context);
      final errorMessage = e.toString().split(" ")[1];
      showAlertDialog(context, message: errorMessage);
    }
  }
}
