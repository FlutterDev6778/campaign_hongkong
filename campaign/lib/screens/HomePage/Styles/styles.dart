import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/index.dart';

class HomePageStyles {
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

  double headerHeight;
  double newsPanelHeight;

  TextStyle chanllengeNumTextStyle;
  TextStyle chanllengeLabelStyle;
  TextStyle chanllengedesciptionStyle;
  TextStyle dueDescriptionStyle;
  TextStyle dueLabelStyle;
  TextStyle dueTextStyle;

  TextStyle dateStyle;
  TextStyle helloStyle;
  TextStyle nameStyle;
  TextStyle avatarUserNameStyle;

  HomePageStyles(BuildContext context) {}
}

class HomePageMobileStyles extends HomePageStyles {
  HomePageMobileStyles(BuildContext context) : super(context) {
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

    headerHeight = heightDp * 263;
    newsPanelHeight = heightDp * 86;
    mainHeight = deviceHeight - bottombarHeight;

    chanllengeNumTextStyle = TextStyle(
      fontSize: fontSp * 37,
      fontFamily: "Avenir-HeavyOblique",
      color: AppColors.whiteColor,
    );

    chanllengeLabelStyle = TextStyle(
      fontSize: fontSp * 23,
      fontFamily: "Avenir-Heavy",
      color: AppColors.whiteColor,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.0, 3.0),
          blurRadius: 6.0,
          color: Colors.black.withOpacity(0.8),
        ),
      ],
    );

    chanllengedesciptionStyle = TextStyle(
      fontSize: fontSp * 13,
      fontFamily: "Avenir-HeavyOblique",
      color: Color(0xFF10FFED),
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.0, 3.0),
          blurRadius: 6.0,
          color: Colors.black.withOpacity(0.65),
        ),
      ],
    );

    dueDescriptionStyle = TextStyle(
      fontSize: fontSp * 11,
      fontFamily: "Avenir-Medium",
      color: AppColors.whiteColor,
    );

    dueLabelStyle = TextStyle(
      fontSize: fontSp * 11,
      fontFamily: "Avenir-Book",
      color: AppColors.whiteColor,
    );

    dueTextStyle = TextStyle(
      fontSize: fontSp * 12,
      fontFamily: "Avenir-Heavy",
      color: Color(0xFF10FFED),
    );

    dateStyle = TextStyle(
      fontSize: fontSp * 18,
      fontFamily: "Avenir-Heavy",
      color: AppColors.whiteColor,
    );

    helloStyle = TextStyle(
      fontSize: fontSp * 15,
      fontFamily: "Avenir-Heavy",
      color: Color(0xFF4AAD9C),
    );

    nameStyle = TextStyle(
      fontSize: fontSp * 20,
      fontFamily: "Avenir-Light",
      color: AppColors.whiteColor,
    );

    avatarUserNameStyle = TextStyle(
      fontSize: fontSp * 14,
      color: AppColors.whiteColor,
    );
  }
}
