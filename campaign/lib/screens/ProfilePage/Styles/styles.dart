import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/index.dart';

class ProfilePageStyles {
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

  double mainPanelHorizontalPadding;
  double mainPanelWidth;
  double mainPanelHeight;

  double barWidth;
  double barHeight;
  double lineHeight;

  ProfilePageStyles(BuildContext context) {}
}

class ProfilePageMobileStyles extends ProfilePageStyles {
  ProfilePageMobileStyles(BuildContext context) : super(context) {
    ScreenUtil.init(context,
        designSize: Size(ResponsiveDesignSettings.mobileDesignWidth, ResponsiveDesignSettings.mobileDesignHeight), allowFontScaling: false);

    devicePixelRatio = ScreenUtil().pixelRatio;
    deviceWidth = ScreenUtil().screenWidth;
    deviceHeight = ScreenUtil().screenHeight;
    statusbarHeight = ScreenUtil().statusBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    bottombarHeight = ScreenUtil().bottomBarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setWidth(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);

    mainPanelHorizontalPadding = widthDp * 34;
    mainPanelWidth = deviceWidth - mainPanelHorizontalPadding * 2;
    mainPanelHeight = heightDp * 330;

    barWidth = widthDp * 178;
    barHeight = heightDp * 10;
    lineHeight = heightDp * 18;
  }
}
