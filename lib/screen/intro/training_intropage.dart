import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sport_app/screen/intro/warmup/warmuppage.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/theme/color.dart';

/// 訓練教學頁
class TrainingIntroPage extends StatefulWidget {
  const TrainingIntroPage({Key? key}) : super(key: key);
  static const String routeName = "/train_intro";

  @override
  State<TrainingIntroPage> createState() => _TrainingIntroPageState();
}

Widget _tutorialScreen(BuildContext context) {
  //一般模式 二頭肌教學
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageSlideshow(
        width: MediaQuery.of(context).size.width / 1.05,
        height: MediaQuery.of(context).size.height / 1.8,
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
        autoPlayInterval: 3000,
        isLoop: true,
      ),
    ],
  );
}

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

class _TrainingIntroPageState extends State<TrainingIntroPage> {
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
              const SizedBox(height: 10),
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
      title: const Text("訓練教學"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Main.routeName);
        },
      ),
    );
  }
}
