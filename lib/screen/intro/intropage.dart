///引導頁

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/intro/warmup/warmuppage.dart';
import 'package:sport_app/screen/main_page.dart';
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
  bool _mode5 = false;
  bool _mode6 = false;
  //
  var mode = 8;
  var introScreen = 8;
  //控制widget的出現
  bool switchBtnofs = false;
  bool bicepsOfs = true;
  bool testOfs = false;
  bool trainOfs = true;
  bool deltoidOfs = true;
  bool quadricepsOfs = true;
  bool quadricepschairOfs = true;
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
                  _mode5 = false;
                  _mode6 = false;
                  bicepsOfs = true;
                  testOfs = false;
                  trainOfs = true;
                  deltoidOfs = true;
                  quadricepsOfs = true;
                  quadricepschairOfs = true;
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
            width: 10,
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
                  _mode5 = false;
                  _mode6 = false;
                  bicepsOfs = true;
                  testOfs = true;
                  trainOfs = false;
                  deltoidOfs = true;
                  quadricepsOfs = true;
                  quadricepschairOfs = true;
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
            width: 10,
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
                  _mode5 = false;
                  _mode6 = false;
                  bicepsOfs = false;
                  testOfs = true;
                  trainOfs = true;
                  deltoidOfs = true;
                  quadricepsOfs = true;
                  quadricepschairOfs = true;
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
            width: 10,
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
                  _mode5 = false;
                  _mode6 = false;
                  bicepsOfs = true;
                  testOfs = true;
                  trainOfs = true;
                  deltoidOfs = false;
                  quadricepsOfs = true;
                  quadricepschairOfs = true;
                });
              },
              child: const Text(
                "三角肌",
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

  Widget _switchCheckbox1() {
    //上排切換按鈕
    return Offstage(
      offstage: switchBtnofs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mode1 = false;
                  _mode2 = false;
                  _mode3 = false;
                  _mode4 = false;
                  _mode5 = true;
                  _mode6 = false;
                  bicepsOfs = true;
                  testOfs = true;
                  trainOfs = true;
                  deltoidOfs = true;
                  quadricepsOfs = false;
                  quadricepschairOfs = true;
                });
              },
              child: const Text(
                "滑牆深蹲",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: _mode5 ? secondColor : primaryColor,
                elevation: 5,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _mode1 = false;
                  _mode2 = false;
                  _mode3 = false;
                  _mode4 = false;
                  _mode5 = false;
                  _mode6 = true;
                  bicepsOfs = true;
                  testOfs = true;
                  trainOfs = true;
                  deltoidOfs = true;
                  quadricepsOfs = true;
                  quadricepschairOfs = false;
                });
              },
              child: const Text(
                "座椅深蹲",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: _mode6 ? secondColor : primaryColor,
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
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254710897033307/00new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254711362584626/01new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254711748472882/02new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254712125968424/03new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254712595718215/04new.png',
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

  Widget _deltoidTutorialScreen02(
    BuildContext context,
  ) {
    //對應三角肌按鈕
    return Offstage(
      offstage: deltoidOfs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 1.8,
            children: [
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254753561493504/00new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254753876062278/01new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254754215788544/02new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254754559737967/03new.png',
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

  Widget _quadricepsTutorialScreen(
    BuildContext context,
  ) {
    //對應滑牆按鈕
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
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254876332961833/0new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254876660109385/01new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254877075357816/02new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254877486395393/03new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254877855502396/04new.png',
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

  Widget _quadricepschairTutorialScreen(
    BuildContext context,
  ) {
    //對應滑牆按鈕
    return Offstage(
      offstage: quadricepschairOfs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageSlideshow(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 1.8,
            children: [
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254809513492490/00new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254809953902713/01new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254810469806100/02new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254810973126837/03new.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254811480641536/04new.png',
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
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254975494701126/01.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254975922520114/02.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254976610390056/03.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254977042387035/04.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254977457619014/05.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254977898029166/06.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254978590081024/07.png',
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.discordapp.com/attachments/1033254616411951154/1033254979097600000/08.png',
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
    String _urll = 'https://youtu.be/QsvvNAenL5k';
    if (testOfs == false) {
      _urll = 'https://youtu.be/QsvvNAenL5k';
    }
    if (trainOfs == false) {
      _urll = 'https://www.youtube.com/watch?v=xCXtPI32Hgk';
    }
    if (bicepsOfs == false) {
      _urll = 'https://www.youtube.com/watch?v=N3Ex1fonMUs';
    }
    if (deltoidOfs == false) {
      _urll = 'https://www.youtube.com/watch?v=Kcd570UidXY';
    }
    if (quadricepsOfs == false) {
      _urll = 'https://www.youtube.com/watch?v=K9Ju-2ZF8g8';
    }
    if (quadricepschairOfs == false) {
      _urll = 'https://www.youtube.com/watch?v=8_1Qpq4WPbY';
    }

    return Offstage(
        offstage: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: ElevatedButton(
            onPressed: () {
              launch(_urll,
                  forceSafariVC: false,
                  forceWebView: false,
                  universalLinksOnly: true);
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
          deltoidOfs = true;
          quadricepsOfs = true;
          quadricepschairOfs = true;
        }
        if (mode == 1) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = true;
          testOfs = false;
          deltoidOfs = true;
          quadricepsOfs = true;
          quadricepschairOfs = true;
        }
        if (mode == 2) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = false;
          testOfs = true;
          deltoidOfs = true;
          quadricepsOfs = true;
          quadricepschairOfs = true;
        }
        if (mode == 4) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = true;
          testOfs = true;
          deltoidOfs = false;
          quadricepsOfs = true;
          quadricepschairOfs = true;
        }
        if (mode == 5) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = true;
          testOfs = true;
          deltoidOfs = true;
          quadricepsOfs = false;
          quadricepschairOfs = true;
        }
        if (mode == 6) {
          _startBtn1 = false;
          switchBtnofs = true;
          bicepsOfs = true;
          testOfs = true;
          deltoidOfs = true;
          quadricepsOfs = true;
          quadricepschairOfs = false;
        }
        prefs.remove('introScreen');
      });
    } catch (error) {}
  }

  @override
  initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('changePage', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 1),
              _switchCheckbox(),
              _switchCheckbox1(),
              const SizedBox(height: 10),
              _bicepsTutorialScreen(context),
              _testTutorialScreen01(
                context,
              ),
              _trainTutorialScreen01(context),
              _deltoidTutorialScreen02(
                context,
              ),
              _quadricepsTutorialScreen(context),
              _quadricepschairTutorialScreen(context),

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
