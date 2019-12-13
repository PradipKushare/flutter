import 'package:flutter/material.dart';
import 'package:flamedemo/components/login_component.dart';
import 'package:flamedemo/components/logo_widget.dart';
import 'package:flamedemo/screens/login_screen.dart';
import 'package:flamedemo/utils/colors.dart';
import 'package:flamedemo/utils/routes.dart';
import 'package:flamedemo/utils/screen_util.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      AppRoutes.makeFirst(context, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    Constant.setScreenAwareConstant(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BackgroundImageWidget(
              color: AppColors.secondary,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: AppLogoWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
