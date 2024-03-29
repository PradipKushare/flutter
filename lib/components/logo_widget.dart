import 'package:flutter/material.dart';
import 'package:flamedemo/utils/assets.dart';
import 'package:flamedemo/utils/screen_util.dart';
import 'package:flamedemo/utils/strings.dart';

class AppLogoWidget extends StatelessWidget {
  final double size;
  final String image;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const AppLogoWidget({Key key, this.margin, this.padding, this.size, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppStrings.appName,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? Constant.spacingAllSmall,
        child: Image(
          image: AssetImage(image ?? Assets.logo),
          height: size ?? Constant.defaultImageHeight,
          width: size ?? Constant.defaultImageHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
      child: Text(
        AppStrings.appName,
        style: TextStyle(
          fontFamily: 'Rubik-Bold',
          fontSize: FontSize.s26,
          color: Color(0xFF008482),
          shadows: [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
          letterSpacing: 5.0,
          inherit: false,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
