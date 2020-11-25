import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../App/index.dart';
import 'colors.dart';

class BottomNavbarStyles {
  double devicePixelRatio;
  double deviceWidth;
  double deviceHeight;
  double statusbarHeight;
  double bottombarHeight;
  double appbarHeight;
  double mainHeight;
  double shareWidth;
  double shareHeight;
  double widthDp;
  double heightDp;
  double fontSp;

  double bottomNavbarHeight;
  TextStyle bottomTextStyle;
  double iconSize;
  double circularSize;

  BottomNavbarStyles(BuildContext context) {}
}

class BottomNavbarMobileStyles extends BottomNavbarStyles {
  BottomNavbarMobileStyles(BuildContext context) : super(context) {
    ScreenUtil.init(
      context,
      designSize: Size(ResponsiveDesignSettings.mobileDesignWidth, ResponsiveDesignSettings.mobileDesignHeight),
      allowFontScaling: false,
    );

    devicePixelRatio = ScreenUtil().pixelRatio;
    deviceWidth = ScreenUtil().screenWidth;
    deviceHeight = ScreenUtil().screenHeight;
    statusbarHeight = ScreenUtil().statusBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    bottombarHeight = ScreenUtil().bottomBarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);
    mainHeight = deviceHeight - bottombarHeight;

    bottomNavbarHeight = widthDp * 95;
    bottomTextStyle = TextStyle(
      fontSize: fontSp * 12,
      fontFamily: "Avenir-Medium",
      color: BottomNavbarColors.textColor,
    );
    iconSize = widthDp * 40;
    circularSize = widthDp * 58;
  }
}
