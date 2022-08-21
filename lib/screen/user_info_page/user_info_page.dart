import 'package:flutter/material.dart';
import 'package:sport_app/screen/user_info_page/user_info_edit_page.dart';
import 'package:sport_app/theme/color.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);
  static const String routeName = "/userinfo";

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  var userName = 'User';
  var birth = '1960/01/01';
  var gender = true;
  var height = '172';
  var weight = '70';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(),
      body: Column(
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
            userName,
            style: const TextStyle(
              fontSize: 30,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 10),
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
                  birth,
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
            margin: const EdgeInsets.only(left: 20, right: 20),
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
                TextButton(
                  child: const Text('男'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text('女'),
                  onPressed: () {},
                )
              ],
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, right: 15),
            margin: const EdgeInsets.only(left: 20, right: 20),
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
                  height,
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
            margin: const EdgeInsets.only(left: 20, right: 20),
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
                  weight,
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
            margin: const EdgeInsets.only(left: 20, right: 20),
            constraints: const BoxConstraints(maxHeight: 56),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
            ),
          ),
          const SizedBox(height: 60),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, UserInfoEditPage.routeName);
            },
            child: Ink(
              height: 36,
              width: 280,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Container(
                child: const Text('編輯',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('個人資訊'),
    );
  }
}
