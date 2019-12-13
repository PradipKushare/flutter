import 'package:flamedemo/drawerList.dart';
import 'package:flamedemo/shopping/titlepage.dart';
import 'package:flutter/material.dart';
// import 'package:flamedemo/screens/splash_screen.dart';
import 'package:flamedemo/utils/colors.dart';

import 'grossary/HomeScreen.dart';

 void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: AppColors.primary),
    );
  }
}