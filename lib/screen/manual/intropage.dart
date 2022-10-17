///引導頁

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/warmup/warmuppage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);
  static const String routeName = "/intro";

  @override
  State<IntroPage> createState() => _IntroPageState();
}

// Widget _tutorialScreen03(BuildContext context) {
//   //視覺模式 統一教學
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       ImageSlideshow(
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: MediaQuery.of(context).size.height / 2.5,
//         children: [
//           Image.network(
//             'https://media.discordapp.net/attachments/969605378407038976/976280448504307753/IMG_1072.jpg?width=811&height=676',
//             fit: BoxFit.cover,
//           ),
//           Image.network(
//             'https://media.discordapp.net/attachments/969605378407038976/976280448504307753/IMG_1072.jpg?width=811&height=676',
//             fit: BoxFit.cover,
//           ),
//           Image.network(
//             'https://media.discordapp.net/attachments/969605378407038976/976280448504307753/IMG_1072.jpg?width=811&height=676',
//             fit: BoxFit.cover,
//           ),
//         ],
//         onPageChanged: (value) {},
//         autoPlayInterval: 3000,
//         isLoop: true,
//       ),
//     ],
//   );
// }

// Widget _CurrentAngle() {
//   return const Text(
//     '當前角度: 3',
//     style: TextStyle(
//         color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
//   );
// }

// Widget _ResetZero(BuildContext context) {
//   return Container(
//     width: MediaQuery.of(context).size.width / 3,
//     child: ElevatedButton(
//       onPressed: () {},
//       child: const Text(
//         '起始角度歸零',
//         style: TextStyle(fontSize: 16),
//       ),
//       style: ElevatedButton.styleFrom(
//         primary: primaryColor,
//       ),
//     ),
//   );
// }

class _IntroPageState extends State<IntroPage> {
  //控制按鈕顏色深淺
  bool _mode1 = true;
  bool _mode2 = false;
  bool _mode3 = false;
  bool _mode4 = false;
  //
  var mode = 8;
  var introScreen = 8;
  //控制widget的出現
  bool switchBtnofs = false;
  bool bicepsOfs = true;
  bool testOfs = false;
  bool trainOfs = true;
  bool quadricepsOfs = true;
  bool _startBtn1 = true;
  //

  Widget _switchCheckbox() {
    //上排切換按鈕
    return Offstage(
      offstage: switchBtnofs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mode1 = true;
                  _mode2 = false;
                  _mode3 = false;
                  _mode4 = false;
                  bicepsOfs = true;
                  testOfs = false;
                  trainOfs = true;
                  quadricepsOfs = true;
                });
              },
              child: const Text(
                "測試",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: _mode1 ? secondColor : primaryColor,
                elevation: 5,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mode1 = false;
                  _mode2 = true;
                  _mode3 = false;
                  _mode4 = false;
                  bicepsOfs = true;
                  testOfs = true;
                  trainOfs = false;
                  quadricepsOfs = true;
                });
              },
              child: const Text(
                "訓練",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: _mode2 ? secondColor : primaryColor,
                elevation: 5,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mode1 = false;
                  _mode2 = false;
                  _mode3 = true;
                  _mode4 = false;
                  bicepsOfs = false;
                  testOfs = true;
                  trainOfs = true;
                  quadricepsOfs = true;
                });
              },
              child: const Text(
                "二頭肌",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: _mode3 ? secondColor : primaryColor,
                elevation: 5,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mode1 = false;
                  _mode2 = false;
                  _mode3 = false;
                  _mode4 = true;
                  bicepsOfs = true;
                  testOfs = true;
                  trainOfs = true;
                  quadricepsOfs = false;
                });
              },
              child: const Text(
                "坐蹲",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: _mode4 ? secondColor : primaryColor,
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _startBtn(BuildContext context) {
    return Offstage(
        offstage: _startBtn1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, WarmupPage.routeName);
            },
            child: const Text('開始熱身', style: TextStyle(fontSize: 24)),
            style: ElevatedButton.styleFrom(primary: primaryColor),
          ),
        ));
  }

  Widget _bicepsTutorialScreen(BuildContext context) {
    //對應二頭按鈕
    return Offstage(
      offstage: bicepsOfs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 1.8,
            children: [
              Image.network(
                //ZERO
                'https://cdn.discordapp.com/attachments/800700545169883189/1031564610802831461/01new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1031564611469709352/02new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1031564611872378890/03new.png',
                fit: BoxFit.contain,
              ),
            ],
            onPageChanged: (value) {},
            autoPlayInterval: 30000,
            isLoop: false,
          ),
        ],
      ),
    );
  }

  Widget _quadricepsTutorialScreen02(
    BuildContext context,
  ) {
    //對應坐蹲按鈕
    return Offstage(
      offstage: quadricepsOfs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 1.8,
            children: [
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1031565024717721661/01new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1031565025078423572/02new.png',
                fit: BoxFit.contain,
              ),
            ],
            onPageChanged: (value) {},
            autoPlayInterval: 30000,
            isLoop: false,
          ),
        ],
      ),
    );
  }

  Widget _testTutorialScreen01(
    BuildContext context,
  ) {
    //對應測試按鈕
    return Offstage(
      offstage: testOfs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 1.8,
            children: [
              Image.network(
                //1
                'https://i.imgur.com/4sdad4j.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793643495268473/02.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793643931475988/03.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793644275404870/04.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793644711616572/05.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793645189767249/06.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793645672124446/07.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793646137679913/08.png',
                fit: BoxFit.contain,
              ),
            ],
            onPageChanged: (value) {},
            autoPlayInterval: 30000,
            isLoop: false,
          ),
        ],
      ),
    );
  }

  Widget _trainTutorialScreen01(
    BuildContext context,
  ) {
    //對應訓練按鈕
    return Offstage(
      offstage: trainOfs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 1.8,
            children: [
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793723195445278/01.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793723581321246/02.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793723958808616/03.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793724927672440/04.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793725384867861/05.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793725804298260/06.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793726185979924/07.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/800700545169883189/1030793726584422450/08.png',
                fit: BoxFit.contain,
              ),
            ],
            onPageChanged: (value) {},
            autoPlayInterval: 30000,
            isLoop: true,
          ),
        ],
      ),
    );
  }

  Widget _videoHyperlinkbtn(BuildContext context) {
    Uri _url = Uri.parse('https://www.youtube.com/watch?v=QRUh75zgpM4');
    if (testOfs == false) {
      _url = Uri.parse('https://www.youtube.com/watch?v=QRUh75zgpM4');
    }
    if (trainOfs == false) {
      _url = Uri.parse('https://www.youtube.com/watch?v=P5uZCj4_X3o');
    }
    return Offstage(
        offstage: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: ElevatedButton(
            onPressed: () {
              launchUrl(
                _url,
              );
            },
            child: const Text('影片連結', style: TextStyle(fontSize: 24)),
            style: ElevatedButton.styleFrom(primary: primaryColor),
          ),
        ));
  }

//introPage用途與圖片內容待修改

  _asyncMethod() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      introScreen = prefs.getInt('introScreen')!;
      setState(() {
        mode = 8;
        switchBtnofs = false;
        mode = introScreen;
        if (mode == 0) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = false;
          testOfs = true;
          quadricepsOfs = true;
        }
        if (mode == 1) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = true;
          testOfs = false;
          quadricepsOfs = true;
        }
        if (mode == 2) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = false;
          testOfs = true;
          quadricepsOfs = true;
        }
        if (mode == 4) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = true;
          testOfs = true;
          quadricepsOfs = false;
        }
        prefs.remove('introScreen');
      });
    } catch (error) {}
  }

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 5),
              _switchCheckbox(),
              const SizedBox(height: 10),
              _bicepsTutorialScreen(context),
              _testTutorialScreen01(
                context,
              ),
              _trainTutorialScreen01(context),
              _quadricepsTutorialScreen02(
                context,
              ),

              // _CurrentAngle(),

              // _ResetZero(context),
              const SizedBox(height: 20),
              _startBtn(context),

              _videoHyperlinkbtn(context),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('流程教學'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Main.routeName);
        },
      ),
    );
  }
}
