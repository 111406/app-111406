import 'package:flutter/material.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/theme/color.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const String routeName = "/changepassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

Widget _forgotPsConfBtn(BuildContext context) {
  //確認修改按鈕
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    height: 90,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, Main.routeName);
      },
      child: const Text('確認修改', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: Column(
            children: [
              appLogo(),
              pageTitle('修改密碼'),
              const SizedBox(height: 20),
              textField(
                obscureText: true,
                textFieldName: '舊密碼',
                hintText: '請輸入舊密碼',
                icon: Icons.lock,
                controller: oldPasswordController,
              ),
              const SizedBox(height: 20),
              textField(
                obscureText: true,
                textFieldName: '新密碼',
                hintText: '請輸入新密碼',
                icon: Icons.lock,
                controller: newPasswordController,
              ),
              const SizedBox(height: 20),
              textField(
                obscureText: true,
                textFieldName: '確認密碼',
                hintText: '確認密碼',
                icon: Icons.lock,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 20),
              _forgotPsConfBtn(context),
            ],
          ),
        ),
      ),
    );
  }
}
