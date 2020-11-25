import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/index.dart';

class LinkBankAccountPageStyles {
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

  double itemWidth;
  double itemHeight;
  double itemBorderRadius;

  TextStyle textStyle;
  TextStyle hintStyle;

  LinkBankAccountPageStyles(BuildContext context) {}
}

class LinkBankAccountPageMobileStyles extends LinkBankAccountPageStyles {
  LinkBankAccountPageMobileStyles(BuildContext context) : super(context) {
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

    itemWidth = widthDp * 303;
    itemHeight = heightDp * 52;
    itemBorderRadius = heightDp * 10;

    textStyle = TextStyle(fontSize: fontSp * 20, color: Colors.white, fontFamily: "Avenir-Roman");
    hintStyle = TextStyle(fontSize: fontSp * 20, color: Colors.grey, fontFamily: "Avenir-Roman", fontStyle: FontStyle.italic);
  }
}
