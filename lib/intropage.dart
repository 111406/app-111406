import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

Widget _TutorialScreen(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        child: Text('教學畫面'),
        alignment: Alignment.center,
      ),
    ],
  );
}

Widget _CurrentAngle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '當前角度：3',
    style: TextStyle(
        color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
  );
}

Widget _ResetZero(BuildContext context) {
  Color primaryColor = HexColor("7C9C99");
  return Container(
    width: MediaQuery.of(context).size.width / 3,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        '起始角度歸零',
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

Widget _StartBtn(BuildContext context) {
  Color primaryColor = HexColor("7C9C99");
  return Container(
    width: MediaQuery.of(context).size.width / 1.5,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        '開始',
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

class _IntroPageState extends State<IntroPage> {
  Color primaryColor = HexColor("7C9C99");
  Color secondColor = HexColor("4E605E");
  Color thirdColor = HexColor("AAD4D0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 70 + 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 36,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text('教學引導'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              _TutorialScreen(context),
              SizedBox(
                height: 30,
              ),
              _CurrentAngle(),
              SizedBox(
                height: 10,
              ),
              _ResetZero(context),
              SizedBox(
                height: 30,
              ),
              _StartBtn(context),
            ],
          ),
        ],
      ),
    );
  }
}