///註冊第一頁

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/common/getxbuilder.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/screen/regitster/components/register_radiobutton.dart';
import 'package:sport_app/screen/regitster/register_controller.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';

import '../../enum/gender.dart';
import 'components/register_component.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());

  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final emailController = TextEditingController();

  late String userId, password, email, walletAddress, privateKey;
  late int sum;
  bool initBirth = false;
  DateTime birth = DateTime(1960, 1, 1);
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final referenceController = TextEditingController();
  final institutionController = TextEditingController();

  @override
  void initState() {
    _loadState();
    super.initState();
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    emailController.dispose();

    heightController.dispose();
    weightController.dispose();
    referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBindWidget(
        bind: controller,
        child: GetBuilder<RegisterController>(
          builder: (controller) => SafeArea(
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Column(
                    children: [
                      appLogo(),
                      pageTitle('註冊'),
                      const SizedBox(height: 5),
                      // 帳號相關
                      Column(
                        children: [
                          textField(
                            textFieldName: '帳號',
                            hintText: '請輸入帳號',
                            icon: Icons.account_box_rounded,
                            controller: userIdController,
                            keyboardType: TextInputType.name,
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z0-9]"))
                            ],
                          ),
                          const SizedBox(height: 10),
                          textField(
                            textFieldName: '密碼',
                            hintText: '請輸入密碼',
                            obscureText: true,
                            icon: Icons.lock,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 10),
                          textField(
                            textFieldName: '確認密碼',
                            hintText: '確認密碼',
                            obscureText: true,
                            icon: Icons.lock,
                            controller: cpasswordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 10),
                          textField(
                            textFieldName: '信箱',
                            hintText: '請輸入信箱',
                            icon: Icons.email,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 個人資訊
                      Column(
                        children: [
                          // 性別
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "性別",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: radioButton(
                                    text: '選擇性別',
                                    fontSize: 20,
                                    groupValue: controller.gender,
                                    updateGroupValue: controller.setGender,
                                    falseName: "男",
                                    trueName: "女"),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          // 生日
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '生日',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: _datePicker,
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.account_box_rounded,
                                          color: primaryColor),
                                      const SizedBox(width: 10),
                                      Text(
                                        (initBirth)
                                            ? DateFormat('yyyy / MM / dd')
                                                .format(birth)
                                            : '請選擇出生年月日(西元)',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: (initBirth)
                                              ? Colors.black
                                              : textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          textField(
                            textFieldName: '身高',
                            hintText: '請輸入身高 (公分)',
                            icon: Icons.account_box_rounded,
                            controller: heightController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]"))
                            ],
                          ),
                          const SizedBox(height: 10),
                          textField(
                            textFieldName: '體重',
                            hintText: '請輸入體重 (公斤)',
                            icon: Icons.account_box_rounded,
                            controller: weightController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]"))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 三高
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '是否有三高',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                radioButton(
                                    text: '高血壓',
                                    groupValue: controller.hypertension,
                                    updateGroupValue:
                                        controller.setHypertension),
                                radioButton(
                                    text: '高血糖',
                                    groupValue: controller.hyperglycemia,
                                    updateGroupValue:
                                        controller.setHyperglycemia),
                                radioButton(
                                    text: '高血脂',
                                    groupValue: controller.hyperlipidemia,
                                    updateGroupValue:
                                        controller.setHyperlipidemia),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: radioButton(
                            text: '運動習慣',
                            fontSize: 20,
                            groupValue: controller.exerciseHabits,
                            updateGroupValue: controller.setExerciseHabits),
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '單位/機構',
                        hintText: '請輸入現處單位或機構 (選填)',
                        icon: Icons.business_center_rounded,
                        controller: institutionController,
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '推薦人',
                        hintText: '請輸入推薦人 (選填)',
                        icon: Icons.account_box_rounded,
                        controller: referenceController,
                      ),
                      const SizedBox(height: 40),
                      mainBtn(
                        text: '完成 / 返回登入',
                        onPressed: _onPressed,
                      ),
                      const SizedBox(height: 50),
                      backToLoginButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadingCircle() async {
    //讀取
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('changePage', false);
    Timer? _timer1;
    late double _progress;
    EasyLoading.instance
      ..backgroundColor = primaryColor
      ..textColor = Colors.white
      ..progressColor = Colors.white
      ..maskColor = Colors.white70
      ..displayDuration = const Duration(milliseconds: 10000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false;

    _progress = 0;
    _timer1?.cancel();
    _timer1 = Timer.periodic(
      const Duration(milliseconds: 500),
      (Timer timer) async {
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.05;

        if (_progress >= 1) {
          _timer1?.cancel();
          EasyLoading.dismiss();
        }
      },
    );
    //讀取結束
  }

  void _datePicker() async {
    initBirth = true;
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

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userIdController.text = prefs.getString("userId") ?? "";
      emailController.text = prefs.getString("email") ?? "";
    });
  }

  void _onPressed() async {
    final userId = userIdController.text,
        password = passwordController.text,
        confirmPassword = cpasswordController.text,
        email = emailController.text,
        height = heightController.text,
        weight = weightController.text,
        birthday = DateFormat('yyyyMMdd').format(birth),
        reference = referenceController.text,
        institution = institutionController.text;

    bool _textFieldIsNotEmpty = userId.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        email.isNotEmpty &&
        height.isNotEmpty &&
        weight.isNotEmpty;

    // bool _threeHighIsNotNull = (hypertension != null) &&
    //     (hypertension != null) &&
    //     (hypertension != null);

    bool _birthIsNotEmpty = initBirth;
    bool _passwordCheck = (password == confirmPassword);

    _loadingCircle();

    if (!_passwordCheck) {
      showAlertDialog(
        context,
        title: '密碼與確認密碼不相同',
        message: '請重新輸入',
      );
    }

    // add account
    Object accountrawData = {};

    await HttpRequest.post(
            "${HttpURL.ethHost}/addAccount", jsonEncode(accountrawData))
        .then((response) {
      walletAddress = response['walletAddress'];
      privateKey = response['privateKey'];
      sum = int.parse(response['sum']);
    });

    if (_textFieldIsNotEmpty && _birthIsNotEmpty) {
      Gender gender = controller.gender ? Gender.female : Gender.male;
      Map otherDetail = {
        "isHadHypertension": controller.hypertension,
        "isHadHyperglycemia": controller.hyperglycemia,
        "isHadHyperlipidemia": controller.hyperlipidemia,
        "isHadExerciseHabits": controller.exerciseHabits,
      };

      // TODO 欄位驗證
      Map requestData = {
        "user_id": userId,
        "password": password,
        "email": email,
        "gender": gender.value,
        "height": height,
        "weight": weight,
        "birthday": birthday,
        "eth_account": walletAddress,
        "eth_password": privateKey,
        "eth_sum": sum,
        "other_detail": jsonEncode(otherDetail)
      };

      // TODO wrap to method
      if (reference.isNotEmpty) requestData['reference'] = reference;
      if (institution.isNotEmpty) requestData['institution'] = institution;

      try {
        final response = await HttpRequest.post(
            '${HttpURL.host}/user/signup', jsonEncode(requestData));

        showAlertDialog(context, message: response['message']).then((_) =>
            Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.routeName, (route) => false));
      } on Exception catch (e) {
        showAlertDialog(
          context,
          title: '發生錯誤',
          message: e.toString().split(' ')[1],
        );
      }
    } else {
      showAlertDialog(
        context,
        title: '輸入框不得為空白',
        message: '請重新輸入',
      );
    }
  }
}
