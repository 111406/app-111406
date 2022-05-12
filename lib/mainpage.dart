import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color primaryColor = HexColor("7C9C99");
  Color secondColor = HexColor("4E605E");
  Color thirdColor = HexColor("AAD4D0");

  bool _normalHasBeenPressed = true;
  bool _visionHasBeenPressed = false;
  // Color controllerColor = ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 70 + 1,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text('肌動GO'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ring_volume,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ColumnSuper(
            innerDistance: MediaQuery.of(context).size.height / -3.0,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Stack(children: <Widget>[
                  Positioned(
                      top: -200,
                      left: -75,
                      child: Transform.rotate(
                        angle: -1 * (math.pi / 180),
                        child: SvgPicture.asset('assets/icon/tangle.svg',
                            semanticsLabel: 'bkgrdrectangle'),
                      )),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0,
                  left: 0,
                ),
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 5.3,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 40),
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.account_box_rounded,
                              size: 45,
                              color: secondColor,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 40),
                          child: Text(
                            '個人資訊',
                            style: TextStyle(
                              fontSize: 20,
                              color: secondColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            '身高：170CM',
                            style: TextStyle(
                                fontSize: 20,
                                color: secondColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(),
                          child: Text(
                            '體重：70KG',
                            style: TextStyle(
                                fontSize: 20,
                                color: secondColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'BMI：24.2',
                            style: TextStyle(
                                fontSize: 20,
                                color: secondColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.help_outline_sharp,
                      size: 45,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Container(
                    child: Text(
                      '使用教學',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.insert_chart_outlined_outlined,
                      size: 45,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Container(
                    child: Text(
                      '檢視資料',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.report_gmailerrorred_rounded,
                      size: 45,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Container(
                    child: Text(
                      '健康資訊',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 11,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                top: 10, left: MediaQuery.of(context).size.width / 11),
            child: Text(
              '測試項目',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: secondColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.help_outline_sharp,
                      size: 45,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Container(
                    child: Text(
                      '二頭肌',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.insert_chart_outlined_outlined,
                      size: 45,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Container(
                    child: Text(
                      '三頭肌',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.report_gmailerrorred_rounded,
                      size: 45,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  Container(
                    child: Text(
                      '滑牆深蹲',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _normalHasBeenPressed = true;
                      _visionHasBeenPressed = false;
                    });
                  },
                  child: Text(
                    "一般模式",
                    style: const TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: _normalHasBeenPressed ? primaryColor : thirdColor,
                    elevation: 5,
                  ),
                ),
              ),
              SizedBox(
                width: 35,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _normalHasBeenPressed = false;
                      _visionHasBeenPressed = true;
                    });
                  },
                  child: Text(
                    "視覺辨識",
                    style: const TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: _visionHasBeenPressed ? primaryColor : thirdColor,
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
