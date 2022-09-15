import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/warmup/warmuppage.dart';
import 'package:sport_app/theme/color.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);
  static const String routeName = "/intro";

  @override
  State<IntroPage> createState() => _IntroPageState();
}

Widget _tutorialScreen(BuildContext context) {
  //一般模式 二頭肌教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        children: [
          Image.network(
            'https://cc.tvbs.com.tw/img/program/upload/2018/03/23/20180323124208-255596e5.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://sportsplanetmag-aws.hmgcdn.com/public/article/atl_20190325160036_156.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img.edh.tw/c1/1/734/22770752080_b243f771c7.jpg',
            fit: BoxFit.cover,
          ),
        ],
        onPageChanged: (value) {
          print('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    ],
  );
}

Widget _tutorialScreen01(BuildContext context) {
  //一般模式 三角肌教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        children: [
          Image.network(
            'https://superfit.com.tw/wp-content/uploads/2018/11/Deltoid-001-1.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'http://p26.toutiaoimg.com/large/pgc-image/4ab5ff2aaaf04449bfde69db8853a3ad?from=detail&index=1',
            fit: BoxFit.cover,
          ),
          Image.network(
            'http://p26.toutiaoimg.com/large/pgc-image/4ab5ff2aaaf04449bfde69db8853a3ad?from=detail&index=1',
            fit: BoxFit.cover,
          ),
        ],
        onPageChanged: (value) {
          print('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    ],
  );
}

Widget _tutorialScreen02(BuildContext context) {
  //一般模式 滑牆教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        children: [
          Image.network(
            'data:image/jpeg;base64,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',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://3c.yipee.cc/wp-content/uploads/2019/12/851efa3650781511ee0ac837a5f58918-620x413.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://3c.yipee.cc/wp-content/uploads/2019/12/851efa3650781511ee0ac837a5f58918-620x413.jpg',
            fit: BoxFit.cover,
          ),
        ],
        onPageChanged: (value) {
          print('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    ],
  );
}

Widget _tutorialScreen03(BuildContext context) {
  //視覺模式 統一教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
        children: [
          Image.network(
            'https://media.discordapp.net/attachments/969605378407038976/976280448504307753/IMG_1072.jpg?width=811&height=676',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://media.discordapp.net/attachments/969605378407038976/976280448504307753/IMG_1072.jpg?width=811&height=676',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://media.discordapp.net/attachments/969605378407038976/976280448504307753/IMG_1072.jpg?width=811&height=676',
            fit: BoxFit.cover,
          ),
        ],
        onPageChanged: (value) {
          print('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    ],
  );
}

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

Widget _startBtn(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.5,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, WarmupPage.routeName);
      },
      child: const Text('開始熱身', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 70),
              _tutorialScreen(context),
              const SizedBox(height: 30),
              // _CurrentAngle(),
              const SizedBox(height: 10),
              // _ResetZero(context),
              const SizedBox(height: 70),
              _startBtn(context),
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
      title: const Text('測試流程'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Main.routeName);
        },
      ),
    );
  }
}
