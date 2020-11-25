import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/index.dart';

class RegisterChallengePanelStyles {
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

  double windowWidth;
  double windowHeight;

  TextStyle titleStyle;
  TextStyle challengeDayStyle;
  TextStyle startButtonTextStyle;
  TextStyle closeButtonTextStyle;

  RegisterChallengePanelStyles(BuildContext context) {}
}

class RegisterChallengePanelMobileStyles extends RegisterChallengePanelStyles {
  RegisterChallengePanelMobileStyles(BuildContext context) : super(context) {
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

    windowWidth = widthDp * 323;
    windowHeight = heightDp * 800;

    titleStyle = TextStyle(
      fontSize: fontSp * 25,
      color: AppColors.whiteColor,
      fontFamily: "Avenir-Heavy",
      shadows: [
        BoxShadow(
          color: Color(0xFF000000).withOpacity(0.65),
          offset: Offset(0, 3),
          blurRadius: 6,
        )
      ],
    );

    challengeDayStyle = TextStyle(
      fontSize: fontSp * 18,
      color: AppColors.whiteColor,
      fontFamily: "Avenir-Heavy",
      height: 1.5,
      shadows: [
        BoxShadow(
          color: Color(0xFF000000).withOpacity(0.65),
          offset: Offset(0, 3),
          blurRadius: 6,
        )
      ],
    );

    startButtonTextStyle = TextStyle(
      fontSize: fontSp * 16,
      color: Color(0xFF0B0B0B),
      fontFamily: "Avenir-Heavy",
    );

    closeButtonTextStyle = TextStyle(
      fontSize: fontSp * 16,
      color: AppColors.whiteColor,
      fontFamily: "Avenir_Light",
    );
  }
}
