import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/theme/color.dart';

import '../main_page.dart';

class UserInfoEditPage extends StatefulWidget {
  const UserInfoEditPage({Key? key}) : super(key: key);
  static const String routeName = "/userinfo/edit";

  @override
  State<UserInfoEditPage> createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState extends State<UserInfoEditPage> {
  var userName = 'User';
  var birth = DateTime(1960, 1, 1);
  // var gender = true;
  var height = '172';
  var weight = '70';

  heightChange(BuildContext context) {
    // Init
    TextEditingController heightController = new TextEditingController();
    AlertDialog dialog = AlertDialog(
      title: Text("輸入新身高"),
      content: Container(
        child: TextField(
          controller: heightController,
          keyboardType: TextInputType.number,
          maxLines: 1,
        ),
      ),
      actions: [
        ElevatedButton(
            child: Text("確認"),
            style: ElevatedButton.styleFrom(primary: primaryColor),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                height = heightController.text;
              });
            }),
        ElevatedButton(
            child: Text("取消"),
            style: ElevatedButton.styleFrom(primary: primaryColor),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  weightChange(BuildContext context) {
    // Init
    TextEditingController weightController = new TextEditingController();
    AlertDialog dialog = AlertDialog(
      title: Text("輸入新體重"),
      content: Container(
        child: TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          maxLines: 1,
        ),
      ),
      actions: [
        ElevatedButton(
            child: Text("確認"),
            style: ElevatedButton.styleFrom(primary: primaryColor),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                weight = weightController.text;
              });
            }),
        ElevatedButton(
            child: Text("取消"),
            style: ElevatedButton.styleFrom(primary: primaryColor),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar(),
        body: SingleChildScrollView(
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
                        child: Text(
                          DateFormat('yyyy/MM/dd').format(birth),
                          style: const TextStyle(
                            fontSize: 22,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              // const SizedBox(height: 10),
              // Container(
              //   child: Row(
              //     children: [
              //       const Expanded(
              //         child: Text(
              //           '性別',
              //           style: TextStyle(
              //             fontSize: 22,
              //             color: textColor,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       TextButton(
              //         child: const Text('男'),
              //         onPressed: () {},
              //       ),
              //       TextButton(
              //         child: const Text('女'),
              //         onPressed: () {},
              //       )
              //     ],
              //   ),
              //   alignment: Alignment.centerLeft,
              //   padding: const EdgeInsets.only(left: 20, right: 15),
              //   margin: const EdgeInsets.only(left: 20, right: 20),
              //   constraints: const BoxConstraints(maxHeight: 56),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //         color: const Color.fromARGB(255, 225, 225, 225)),
              //   ),
              // ),
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
                    InkWell(
                      onTap: () {
                        heightChange(context);
                      },
                      child: Container(
                        child: Text(
                          height,
                          style: const TextStyle(
                            fontSize: 22,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
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
                    InkWell(
                      onTap: () {
                        weightChange(context);
                      },
                      child: Container(
                        child: Text(
                          weight,
                          style: const TextStyle(
                            fontSize: 22,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              const SizedBox(height: 60),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setInt('returnMainPage', 1);
                  Navigator.pushReplacementNamed(context, Main.routeName);
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
        ));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('編輯 個人資訊'),
      leading: Container(),
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
