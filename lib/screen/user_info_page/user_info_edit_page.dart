import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport_app/screen/user_info_page/user_info_page.dart';
import 'package:sport_app/theme/color.dart';

const textColor = Color(0xff7E7E7E);

class UserInfoEditPage extends StatefulWidget {
  const UserInfoEditPage({Key? key}) : super(key: key);
  static const String routeName = "/userinfo/edit";

  @override
  State<UserInfoEditPage> createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState extends State<UserInfoEditPage> {
  var userName = 'User';
  var birth = DateTime(1960, 1, 1);
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
                InkWell(
                  onTap: _datePicker,
                  child: Container(
                    child: Text(DateFormat('yyyy/MM/dd').format(birth),
                        style: const TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                    alignment: Alignment.center,
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
              Navigator.pushReplacementNamed(context, UserInfoPage.routeName);
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
                child: const Text('完成',
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
      title: const Text('編輯 個人資訊'),
    );
  }

  void _datePicker() async {
    var result = await showDatePicker(
      context: context,
      initialDate: birth,
      firstDate: DateTime(1900, 01),
      lastDate: DateTime(1960, 01),
    );

    if (result != null) {
      setState(() {
        birth = result;
      });
    }
  }
}
