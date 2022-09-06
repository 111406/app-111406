// import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math' as math;

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sport_app/enum/training_part.dart';
// import 'package:sport_app/screen/change_password/change_password.dart';

// import 'package:sport_app/screen/intropage.dart';
// import 'package:sport_app/screen/testpage.dart';
// import 'package:sport_app/test/pose_detector_view.dart';
// import 'package:sport_app/theme/color.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//   static const String routeName = "/main";

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// Widget _Drawer(BuildContext context) {
//   return Container(
//     width: MediaQuery.of(context).size.width / 1.8,
//     child: Drawer(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: MediaQuery.removePadding(
//           context: context,
//           removeTop: true,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 4,
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width / 8),
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Image.asset(
//                           'assets/icon/logo01.png',
//                           width: 100,
//                         ),
//                         const Text(
//                           "肌動GO",
//                           style: TextStyle(
//                             decoration: TextDecoration.none,
//                             // fontFamily: 'OpenSans',
//                             color: primaryColor,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                   child: ListView(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width / 8),
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   ListTile(
//                     title: const Text(
//                       "使用須知",
//                       style: TextStyle(
//                         decoration: TextDecoration.none,
//                         // fontFamily: 'OpenSans',
//                         color: secondColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     title: const Text(
//                       "關於我們",
//                       style: TextStyle(
//                         decoration: TextDecoration.none,
//                         // fontFamily: 'OpenSans',
//                         color: secondColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     title: const Text(
//                       "修改密碼",
//                       style: TextStyle(
//                         decoration: TextDecoration.none,
//                         // fontFamily: 'OpenSans',
//                         color: secondColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const ChangePassword()));
//                     },
//                   ),
//                 ],
//               ))
//             ],
//           )),
//     ),
//   );
// }

// class _MainPageState extends State<MainPage> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   bool _testHasBeenPressed = true;
//   bool _trainHasBeenPressed = false;
//   bool _normalHasBeenPressed = true;
//   bool _visionHasBeenPressed = false;
//   // Color controllerColor = ;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawerEnableOpenDragGesture: false,
//       key: _key,
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         elevation: 0,
//         centerTitle: true,
//         toolbarHeight: 70 + 1,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.menu,
//             color: Colors.white,
//           ),
//           onPressed: () => _key.currentState!.openDrawer(),
//         ),
//         title: const Text('肌動GO'),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.circle_notifications,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ColumnSuper(
//               innerDistance: MediaQuery.of(context).size.height / -3.0,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 3,
//                   decoration: const BoxDecoration(
//                     color: Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                   child: Stack(children: <Widget>[
//                     Positioned(
//                         top: -200,
//                         left: -75,
//                         child: Transform.rotate(
//                           angle: -1 * (math.pi / 180),
//                           child: SvgPicture.asset('assets/icon/tangle.svg',
//                               semanticsLabel: 'bkgrdrectangle'),
//                         )),
//                   ]),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(
//                     top: 0,
//                     left: 0,
//                   ),
//                   width: MediaQuery.of(context).size.width / 1.3,
//                   height: MediaQuery.of(context).size.height / 5,
//                   decoration: BoxDecoration(
//                     color: Colors.green[50],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(top: 25, left: 40),
//                             child: RawMaterialButton(
//                               onPressed: () {},
//                               elevation: 2.0,
//                               fillColor: Colors.white,
//                               child: const Icon(
//                                 Icons.account_box_rounded,
//                                 size: 45,
//                                 color: secondColor,
//                               ),
//                               padding: const EdgeInsets.all(15.0),
//                               shape: const CircleBorder(),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(top: 5, left: 40),
//                             child: const Text(
//                               '個人資訊',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: secondColor,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 22,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 15),
//                             child: const Text(
//                               '身高: 170CM',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: secondColor,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(),
//                             child: const Text(
//                               '體重: 70KG',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: secondColor,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             child: const Text(
//                               'BMI: 24.2',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: secondColor,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     RawMaterialButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const IntroPage()));
//                       },
//                       elevation: 2.0,
//                       fillColor: Colors.white,
//                       child: const Icon(
//                         Icons.help_outline_sharp,
//                         size: 45,
//                         color: primaryColor,
//                       ),
//                       padding: const EdgeInsets.all(15.0),
//                       shape: const CircleBorder(),
//                     ),
//                     Container(
//                       child: const Text(
//                         '使用教學',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   children: [
//                     RawMaterialButton(
//                       onPressed: () {},
//                       elevation: 2.0,
//                       fillColor: Colors.white,
//                       child: const Icon(
//                         Icons.insert_chart_outlined_outlined,
//                         size: 45,
//                         color: primaryColor,
//                       ),
//                       padding: const EdgeInsets.all(15.0),
//                       shape: const CircleBorder(),
//                     ),
//                     Container(
//                       child: const Text(
//                         '檢視資料',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   children: [
//                     RawMaterialButton(
//                       onPressed: () {},
//                       elevation: 2.0,
//                       fillColor: Colors.white,
//                       child: const Icon(
//                         Icons.report_gmailerrorred_rounded,
//                         size: 45,
//                         color: primaryColor,
//                       ),
//                       padding: const EdgeInsets.all(15.0),
//                       shape: const CircleBorder(),
//                     ),
//                     Container(
//                       child: const Text(
//                         '健康資訊',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(
//                   top: 10, left: MediaQuery.of(context).size.width / 11),
//               child: const Text(
//                 '測試項目',
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                     color: secondColor),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Ink(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 2,
//                             )
//                           ]),
//                       child: IconButton(
//                         padding: const EdgeInsets.all(12),
//                         icon: Image.asset('assets/icon/one.png'),
//                         color: Colors.white,
//                         iconSize: 60,
//                         onPressed: () async {
//                           SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           //測試模式與訓練模式的傳值 待修改
//                           //await prefs.setBool('testortrain', _testHasBeenPressed);
//                           //intropage判斷教學引導用
//                           await prefs.setBool(
//                               'normalmode', _normalHasBeenPressed); //一般或視覺
//                           await prefs.setBool('upmode', true); //上肢或下肢
//                           await prefs.setBool('twohead', true); //上肢的二頭或三角
//                           //
//                           await prefs.setInt("part", TrainingPart.biceps.value);
//                           Navigator.pushNamed(
//                               context, IntroPage.routeName); //此為跳轉至intropage
//                           //Navigator.pushNamed(context, TestPage.routeName);
//                         },
//                       ),
//                     ),
//                     Container(
//                       child: const Text(
//                         '二頭肌',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   children: [
//                     Ink(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 2,
//                             )
//                           ]),
//                       child: IconButton(
//                         padding: EdgeInsets.all(12),
//                         icon: Image.asset('assets/icon/two.png'),
//                         color: Colors.white,
//                         iconSize: 60,
//                         onPressed: () async {
//                           SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           //測試模式與訓練模式的傳值 待修改
//                           //await prefs.setBool('testortrain', _testHasBeenPressed);
//                           //intropage判斷教學引導用
//                           await prefs.setBool(
//                               'normalmode', _normalHasBeenPressed);
//                           await prefs.setBool('upmode', true);
//                           await prefs.setBool('twohead', false);
//                           //
//                           await prefs.setInt(
//                               "part", TrainingPart.deltoid.value);

//                           Navigator.pushNamed(
//                               context, IntroPage.routeName); //此為跳轉至intropage
//                           //Navigator.pushNamed(context, TestPage.routeName);
//                         },
//                       ),
//                     ),
//                     Container(
//                       child: const Text(
//                         '三頭肌',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   children: [
//                     Ink(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 2,
//                             )
//                           ]),
//                       child: IconButton(
//                         padding: EdgeInsets.all(12),
//                         icon: Image.asset('assets/icon/three.png'),
//                         color: Colors.white,
//                         iconSize: 60,
//                         onPressed: () async {
//                           SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           //測試模式與訓練模式的傳值 待修改
//                           //await prefs.setBool('testortrain', _testHasBeenPressed);
//                           //intropage判斷教學引導用
//                           await prefs.setBool(
//                               'normalmode', _normalHasBeenPressed);
//                           await prefs.setBool('upmode', false);
//                           await prefs.setBool('twohead', false);
//                           //
//                           await prefs.setInt(
//                               "part", TrainingPart.quadriceps.value);

//                           Navigator.pushNamed(
//                               context, IntroPage.routeName); //此為跳轉至intropage
//                           //Navigator.pushNamed(context, TestPage.routeName);
//                         },
//                       ),
//                     ),
//                     Container(
//                       child: const Text(
//                         '滑牆深蹲',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 30,
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _testHasBeenPressed = true;
//                         _trainHasBeenPressed = false;
//                       });
//                     },
//                     child: const Text(
//                       "測試",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: _testHasBeenPressed ? primaryColor : thirdColor,
//                       elevation: 5,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 35,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 30,
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _testHasBeenPressed = false;
//                         _trainHasBeenPressed = true;
//                       });
//                     },
//                     child: const Text(
//                       "訓練",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: _trainHasBeenPressed ? primaryColor : thirdColor,
//                       elevation: 5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 30,
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _normalHasBeenPressed = true;
//                         _visionHasBeenPressed = false;
//                       });
//                     },
//                     child: const Text(
//                       "一般模式",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary:
//                           _normalHasBeenPressed ? primaryColor : thirdColor,
//                       elevation: 5,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 35,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 30,
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, PoseDetectorView.routeName);
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => const PoseDetectorView()));
//                       setState(() {
//                         _normalHasBeenPressed = false;
//                         _visionHasBeenPressed = true;
//                       });
//                     },
//                     child: const Text(
//                       "視覺辨識",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary:
//                           _visionHasBeenPressed ? primaryColor : thirdColor,
//                       elevation: 5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       drawer: _Drawer(context),
//     );
//   }
// }

// // 切換視覺頁面按鈕
// // child: RaisedButton(
// //             child: Text('Test'),
// //             onPressed: () {
// //               Navigator.push(context,
// //                   MaterialPageRoute(builder: (context) => PoseDetectorView()));
// //             },
// //           ),
