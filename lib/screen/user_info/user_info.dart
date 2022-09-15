import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/user_info/user_info_edit.dart';
import 'package:sport_app/theme/color.dart' as colors;
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/http_request.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);
  static const String routeName = "/userinfo";

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  var userId = '載入中';
  var birth = '19600101';
  var _height = '載入中';
  var _weight = '載入中';
  var _gender = '載入中';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getString("userId");
    await HttpRequest().get('${HttpURL.host}/user/$_userId').then((response) {
      var height = response['data']['height'];
      var weight = response['data']['weight'];
      var birth = response['data']['birthday'];
      var gender = response['data']['gender'];

      prefs.setDouble("height", height);
      prefs.setDouble("weight", weight);
      prefs.setString("birth", birth);
      prefs.setString("gender", gender);
    });

    setState(() {
      userId = prefs.getString("userId") ?? "";
      _height = (prefs.getDouble("height") ?? 0).toString();
      _weight = (prefs.getDouble("weight") ?? 0).toString();
      _gender = prefs.getString("gender") ?? "";
      birth = prefs.getString("birth") ?? "19600101";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: appBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.account_circle_rounded,
                color: Color(0xffB5C0BF),
                size: 100,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userId,
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '出生年月日',
                      style: TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('yyyy/MM/dd').format(DateTime.parse(birth)),
                    style: const TextStyle(
                      fontSize: 22,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 15),
              constraints: const BoxConstraints(maxHeight: 56),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '性別',
                      style: TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    // (gender == 0) ? '男' : '女',
                    _gender,
                    style: const TextStyle(
                      fontSize: 22,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 15),
              constraints: const BoxConstraints(maxHeight: 56),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '身高(公分)',
                      style: TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _height.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 15),
              constraints: const BoxConstraints(maxHeight: 56),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '體重(公斤)',
                      style: TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _weight.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 15),
              constraints: const BoxConstraints(maxHeight: 56),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
              ),
            ),
            const SizedBox(height: 60),
            mainBtn(
              text: '編輯',
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, UserInfoEditPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: colors.secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('個人資訊'),
      leading: Container(),
    );
  }
}
