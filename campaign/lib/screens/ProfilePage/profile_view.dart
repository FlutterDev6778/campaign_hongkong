import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keicy_avatar_image/keicy_avatar_image.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../App/index.dart';

import 'index.dart';

class ProfileView extends StatefulWidget {
  final ProfilePageStyles profilePageStyles;

  const ProfileView({
    Key key,
    this.profilePageStyles,
  }) : super(key: key);

  @override
  _TransferViewState createState() => _TransferViewState();
}

class _TransferViewState extends State<ProfileView> {
  PageController pageController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.profilePageStyles.deviceWidth,
        height: widget.profilePageStyles.deviceHeight,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.profileBack), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: widget.profilePageStyles.statusbarHeight),
              _containerAppbar(context),
              _containerTitle(context),
              SizedBox(height: widget.profilePageStyles.heightDp * 20),
              Container(
                height: widget.profilePageStyles.mainPanelHeight,
                child: PageView(
                  controller: pageController,
                  children: [
                    _containerFirstMainPanel(context),
                    _containerSecondMainPanel(context),
                    _containerThirdMainPanel(context),
                  ],
                ),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotWidth: widget.profilePageStyles.heightDp * 10,
                    dotHeight: widget.profilePageStyles.heightDp * 10,
                    spacing: widget.profilePageStyles.heightDp * 6,
                    dotColor: Color(0xFF868686),
                    activeDotColor: Color(0xFF74FFF5),
                  ),
                ),
              ),
              SizedBox(height: widget.profilePageStyles.heightDp * 15),
              _containerSocialPanel(context),
              Container(height: widget.profilePageStyles.heightDp * 30),
              Row(
                children: [
                  SizedBox(width: widget.profilePageStyles.mainPanelHorizontalPadding),
                  Text(
                    "Achievements",
                    style: TextStyle(
                      fontSize: widget.profilePageStyles.fontSp * 16,
                      color: Colors.white,
                      fontFamily: "Avenir-Book",
                    ),
                  ),
                ],
              ),
              Container(height: widget.profilePageStyles.heightDp * 15),
              _containerAchievements(context),
              Container(height: widget.profilePageStyles.heightDp * 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerBackgroud(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.profilePageStyles.deviceWidth,
          height: widget.profilePageStyles.deviceHeight,
          color: Color(0xFF011D24),
        ),
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            AppAssets.backImage3,
            width: widget.profilePageStyles.deviceWidth,
            height: widget.profilePageStyles.deviceHeight,
            fit: BoxFit.cover,
          ),
        ),
        Opacity(
          opacity: 0.37,
          child: Image.asset(
            AppAssets.backImage1,
            width: widget.profilePageStyles.deviceWidth,
            height: widget.profilePageStyles.deviceHeight,
            fit: BoxFit.cover,
            color: Color(0xFF011D24),
            colorBlendMode: BlendMode.colorDodge,
          ),
        ),
        Positioned(
          bottom: 0,
          right: widget.profilePageStyles.widthDp * 50,
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              AppAssets.profileBackItem1,
              width: widget.profilePageStyles.widthDp * 210,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          top: widget.profilePageStyles.widthDp * 245,
          right: -widget.profilePageStyles.widthDp * 170,
          child: Container(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                AppAssets.profileBackItem2,
                width: widget.profilePageStyles.widthDp * 500,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Container(
          width: widget.profilePageStyles.deviceWidth,
          height: widget.profilePageStyles.deviceHeight,
          decoration: BoxDecoration(
            color: Color(0xFF193390).withOpacity(0.41),
            backgroundBlendMode: BlendMode.color,
          ),
        ),
      ],
    );
  }

  Widget _containerAppbar(BuildContext context) {
    return Container(
      height: widget.profilePageStyles.heightDp * 40,
      padding: EdgeInsets.only(
        left: widget.profilePageStyles.widthDp * 23,
        right: widget.profilePageStyles.widthDp * 37,
        bottom: widget.profilePageStyles.heightDp * 10,
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: widget.profilePageStyles.heightDp * 30,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.dehaze,
            size: widget.profilePageStyles.heightDp * 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _containerTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.profilePageStyles.mainPanelHorizontalPadding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: widget.profilePageStyles.fontSp * 34,
                  color: Colors.white,
                  fontFamily: "Avenir-Heavy",
                ),
              ),
              SizedBox(width: widget.profilePageStyles.widthDp * 15),
              _containerHelperButton(context),
            ],
          ),
          SizedBox(height: widget.profilePageStyles.heightDp * 10),
          Row(
            children: [
              KeicyAvatarImage(
                url: "",
                userName: "JD",
                letters: 1,
                width: widget.profilePageStyles.heightDp * 90,
                height: widget.profilePageStyles.heightDp * 90,
                backColor: Color(0xFF3B3B3B),
                borderWidth: 0,
                textStyle: TextStyle(
                  fontSize: widget.profilePageStyles.fontSp * 39,
                  color: Colors.white,
                  fontFamily: "Avenir-Book",
                ),
              ),
              SizedBox(width: widget.profilePageStyles.widthDp * 18),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.profileIcon1,
                          height: widget.profilePageStyles.heightDp * 56,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: widget.profilePageStyles.widthDp * 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Wealth Stage",
                                style: TextStyle(
                                  fontSize: widget.profilePageStyles.fontSp * 11,
                                  color: Colors.white,
                                  fontFamily: "Avenir-Book",
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Potential",
                                    style: TextStyle(
                                      fontSize: widget.profilePageStyles.fontSp * 26,
                                      color: Colors.white,
                                      fontFamily: "Avenir-Heavy",
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: widget.profilePageStyles.widthDp * 20,
                                          height: widget.profilePageStyles.heightDp * 5,
                                          color: Color(0xFF74FFF5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.profilePageStyles.heightDp * 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Account No.",
                          style: TextStyle(
                            fontSize: widget.profilePageStyles.fontSp * 12,
                            color: Colors.white,
                            fontFamily: "Avenir-Book",
                          ),
                        ),
                        SizedBox(width: widget.profilePageStyles.widthDp * 5),
                        Text(
                          "201475535",
                          style: TextStyle(
                            fontSize: widget.profilePageStyles.fontSp * 17,
                            color: Colors.white,
                            fontFamily: "Avenir-Heavy",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerHelperButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _containerHelperDialog(context);
      },
      child: Container(
        width: widget.profilePageStyles.heightDp * 33,
        height: widget.profilePageStyles.heightDp * 33,
        decoration: BoxDecoration(
          color: Color(0xFF707070),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppAssets.helpIcon,
          height: widget.profilePageStyles.heightDp * 16,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _containerSocialPanel(BuildContext context) {
    return Container(
      width: widget.profilePageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: widget.profilePageStyles.mainPanelHorizontalPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: widget.profilePageStyles.widthDp * 82,
                margin: EdgeInsets.only(left: widget.profilePageStyles.widthDp * 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ossey",
                  style: TextStyle(
                    fontSize: widget.profilePageStyles.widthDp * 20,
                    color: Colors.white,
                    fontFamily: "Avenir-Heavy",
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: widget.profilePageStyles.heightDp * 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRect(
                  child: Container(
                    width: widget.profilePageStyles.heightDp * 40,
                    height: widget.profilePageStyles.heightDp * 50,
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            width: widget.profilePageStyles.heightDp * 40,
                            height: widget.profilePageStyles.heightDp * 60,
                            alignment: Alignment.center,
                            child: Center(
                              child: Container(
                                width: widget.profilePageStyles.heightDp * 15,
                                height: widget.profilePageStyles.heightDp * 30,
                                color: Color(0xFF266CFF),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: widget.profilePageStyles.heightDp * 40,
                            height: widget.profilePageStyles.heightDp * 60,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppAssets.facebookIcon,
                              height: widget.profilePageStyles.heightDp * 40,
                              color: Colors.white,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.instagramIcon,
                  height: widget.profilePageStyles.heightDp * 20,
                  fit: BoxFit.fitHeight,
                ),
                ClipRect(
                  child: Stack(
                    children: [
                      Container(
                        width: widget.profilePageStyles.heightDp * 50,
                        height: widget.profilePageStyles.heightDp * 50,
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppAssets.twitterBackImg,
                          height: widget.profilePageStyles.heightDp * 45,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        width: widget.profilePageStyles.heightDp * 40,
                        height: widget.profilePageStyles.heightDp * 50,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      Container(
                        width: widget.profilePageStyles.heightDp * 40,
                        height: widget.profilePageStyles.heightDp * 50,
                        padding: EdgeInsets.only(left: widget.profilePageStyles.widthDp * 10),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppAssets.twitterIcon,
                          height: widget.profilePageStyles.heightDp * 40,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.emailIcon,
                  height: widget.profilePageStyles.heightDp * 20,
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  width: widget.profilePageStyles.widthDp * 82,
                  height: widget.profilePageStyles.heightDp * 42,
                  margin: EdgeInsets.only(left: widget.profilePageStyles.widthDp * 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 12),
                    color: Color(0xFF073047),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: widget.profilePageStyles.widthDp * 10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "10",
                    style: TextStyle(
                      fontSize: widget.profilePageStyles.widthDp * 23,
                      color: Color(0xFFFACA02),
                      fontFamily: "Avenir-Heavy",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: widget.profilePageStyles.heightDp * 8),
          Row(
            children: [
              Text(
                "Joined since 12 DEC 2019",
                style: TextStyle(
                  fontSize: widget.profilePageStyles.fontSp * 12,
                  color: Color(0xFFC7C7C7),
                  fontFamily: "Avenir-Book",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerFirstMainPanel(BuildContext context) {
    return Container(
      width: widget.profilePageStyles.mainPanelWidth,
      height: widget.profilePageStyles.mainHeight,
      padding: EdgeInsets.symmetric(horizontal: widget.profilePageStyles.mainPanelHorizontalPadding),
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.circularBlurImage,
                      width: widget.profilePageStyles.heightDp * 260,
                      height: widget.profilePageStyles.heightDp * 260,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.profileCirclesImage,
                      width: widget.profilePageStyles.mainPanelWidth,
                      height: widget.profilePageStyles.heightDp * 230,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Column(
                  children: [
                    SizedBox(height: widget.profilePageStyles.heightDp * 36),
                    Container(
                      padding: EdgeInsets.only(left: widget.profilePageStyles.heightDp * 4),
                      child: ClipPath(
                        clipper: CustomClipPath(0.8, 0.7, 0.4),
                        child: Container(
                          width: widget.profilePageStyles.heightDp * 195,
                          height: widget.profilePageStyles.heightDp * 195,
                          decoration: BoxDecoration(
                            color: Color(0xFF69FFFF).withOpacity(0.52),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.deviceWidth,
                child: Column(
                  children: [
                    SizedBox(height: widget.profilePageStyles.heightDp * 36),
                    Container(
                      padding: EdgeInsets.only(left: widget.profilePageStyles.heightDp * 4),
                      child: CustomPaint(
                        size: Size(
                          widget.profilePageStyles.heightDp * 195,
                          widget.profilePageStyles.heightDp * 195,
                        ),
                        painter: Custom1Painter(0.8, 0.7, 0.4, Color(0xFF26E5D4)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: widget.profilePageStyles.mainPanelWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                KeicyRaisedButton(
                  width: widget.profilePageStyles.widthDp * 130,
                  height: widget.profilePageStyles.heightDp * 30,
                  color: Color(0xFF285773),
                  borderRadius: widget.profilePageStyles.heightDp * 10,
                  child: Text(
                    "Your Stage",
                    style: TextStyle(
                      fontSize: widget.profilePageStyles.fontSp * 12,
                      color: Color(0xFF00E5D4),
                      fontFamily: "Avenir-Heavy",
                    ),
                  ),
                ),
                SizedBox(height: widget.profilePageStyles.heightDp * 37),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerSecondMainPanel(BuildContext context) {
    return Container(
      width: widget.profilePageStyles.mainPanelWidth,
      height: widget.profilePageStyles.mainHeight,
      padding: EdgeInsets.symmetric(horizontal: widget.profilePageStyles.mainPanelHorizontalPadding),
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.circularBlurImage,
                      width: widget.profilePageStyles.heightDp * 260,
                      height: widget.profilePageStyles.heightDp * 260,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.profileCirclesImage,
                      width: widget.profilePageStyles.mainPanelWidth,
                      height: widget.profilePageStyles.heightDp * 230,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Column(
                  children: [
                    SizedBox(height: widget.profilePageStyles.heightDp * 36),
                    Container(
                      padding: EdgeInsets.only(left: widget.profilePageStyles.heightDp * 4),
                      child: ClipPath(
                        clipper: CustomClipPath(0.8, 0.7, 0.4),
                        child: Container(
                          width: widget.profilePageStyles.heightDp * 195,
                          height: widget.profilePageStyles.heightDp * 195,
                          decoration: BoxDecoration(
                            color: Color(0xFF69FFFF).withOpacity(0.52),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.deviceWidth,
                child: Column(
                  children: [
                    SizedBox(height: widget.profilePageStyles.heightDp * 36),
                    Container(
                      padding: EdgeInsets.only(left: widget.profilePageStyles.heightDp * 4),
                      child: CustomPaint(
                        size: Size(
                          widget.profilePageStyles.heightDp * 195,
                          widget.profilePageStyles.heightDp * 195,
                        ),
                        painter: Custom1Painter(0.8, 0.7, 0.4, Color(0xFF26E5D4)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.mainPanelWidth,
                child: Column(
                  children: [
                    SizedBox(height: widget.profilePageStyles.heightDp * 36),
                    Container(
                      padding: EdgeInsets.only(left: widget.profilePageStyles.heightDp * 4),
                      child: ClipPath(
                        clipper: CustomClipPath(0.4, 0.3, 0.8),
                        child: Container(
                          width: widget.profilePageStyles.heightDp * 195,
                          height: widget.profilePageStyles.heightDp * 195,
                          decoration: BoxDecoration(
                            color: Color(0xFF1D63FF).withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.profilePageStyles.deviceWidth,
                child: Column(
                  children: [
                    SizedBox(height: widget.profilePageStyles.heightDp * 36),
                    Container(
                      padding: EdgeInsets.only(left: widget.profilePageStyles.heightDp * 4),
                      child: CustomPaint(
                        size: Size(
                          widget.profilePageStyles.heightDp * 195,
                          widget.profilePageStyles.heightDp * 195,
                        ),
                        painter: Custom1Painter(0.4, 0.3, 0.8, Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: widget.profilePageStyles.heightDp * 12,
                        height: widget.profilePageStyles.heightDp * 12,
                        decoration: BoxDecoration(
                          color: Color(0xFF47E6C9),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: widget.profilePageStyles.widthDp * 10),
                      Text(
                        "Your Performance",
                        style: TextStyle(
                          fontSize: widget.profilePageStyles.fontSp * 12,
                          color: Color(0xFF00E5D4),
                          fontFamily: "Avenir-Book",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: widget.profilePageStyles.heightDp * 12,
                        height: widget.profilePageStyles.heightDp * 12,
                        decoration: BoxDecoration(
                          color: Color(0xFF2E6EFF),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: widget.profilePageStyles.widthDp * 10),
                      Text(
                        "Average Performance",
                        style: TextStyle(
                          fontSize: widget.profilePageStyles.fontSp * 12,
                          color: Color(0xFFBCBEFF),
                          fontFamily: "Avenir-Book",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: widget.profilePageStyles.heightDp * 20),
              KeicyRaisedButton(
                width: widget.profilePageStyles.widthDp * 162,
                height: widget.profilePageStyles.heightDp * 30,
                color: Color(0xFF285773),
                borderRadius: widget.profilePageStyles.heightDp * 10,
                child: Text(
                  "Average of same stage",
                  style: TextStyle(
                    fontSize: widget.profilePageStyles.fontSp * 12,
                    color: Color(0xFF00E5D4),
                    fontFamily: "Avenir-Heavy",
                  ),
                ),
              ),
              SizedBox(height: widget.profilePageStyles.heightDp * 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerThirdMainPanel(BuildContext context) {
    double wealthGrowth = 0.7;
    double netWorth = 0.8;
    double incentives = 0.4;

    return Container(
      width: widget.profilePageStyles.mainPanelWidth,
      padding: EdgeInsets.symmetric(horizontal: widget.profilePageStyles.mainPanelHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: widget.profilePageStyles.mainPanelWidth,
            height: widget.profilePageStyles.heightDp * 218,
            decoration: BoxDecoration(
              color: Color(0xFF3B749F),
              borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 10),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.profilePageStyles.widthDp * 17,
              vertical: widget.profilePageStyles.heightDp * 17,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Wealth Growth",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Color(0xFF00E5D4),
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Stack(
                      children: [
                        Container(
                          height: widget.profilePageStyles.lineHeight,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                            child: Container(
                              width: widget.profilePageStyles.barWidth,
                              height: widget.profilePageStyles.barHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                                color: Color(0xFF24618C),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: widget.profilePageStyles.barWidth * wealthGrowth,
                                    height: widget.profilePageStyles.barHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                                      color: Color(0xFF00FFD7),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF00FFD7).withOpacity(0.7),
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: (widget.profilePageStyles.barWidth - widget.profilePageStyles.widthDp * 3) * 0.6),
                            Container(
                              width: widget.profilePageStyles.widthDp * 3,
                              height: widget.profilePageStyles.heightDp * 18,
                              color: Color(0xFF4D7DFC),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: (widget.profilePageStyles.barWidth - widget.profilePageStyles.widthDp * 3) * 0.9),
                            DottedLine(
                              direction: Axis.vertical,
                              lineThickness: widget.profilePageStyles.widthDp * 3,
                              lineLength: widget.profilePageStyles.widthDp * 18,
                              dashLength: 2,
                              dashGapLength: 2,
                              dashColor: Color(0xFFDD4BF8),
                              dashGapColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: widget.profilePageStyles.heightDp * 25),
                Row(
                  children: [
                    Text(
                      "Net Worth",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Color(0xFF00E5D4),
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Stack(
                      children: [
                        Container(
                          height: widget.profilePageStyles.lineHeight,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                            child: Container(
                              width: widget.profilePageStyles.barWidth,
                              height: widget.profilePageStyles.barHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                                color: Color(0xFF24618C),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: widget.profilePageStyles.barWidth * netWorth,
                                    height: widget.profilePageStyles.barHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                                      color: Color(0xFF00FFD7),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF00FFD7).withOpacity(0.7),
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: (widget.profilePageStyles.barWidth - widget.profilePageStyles.widthDp * 3) * 0.6),
                            Container(
                              width: widget.profilePageStyles.widthDp * 3,
                              height: widget.profilePageStyles.heightDp * 18,
                              color: Color(0xFF4D7DFC),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: (widget.profilePageStyles.barWidth - widget.profilePageStyles.widthDp * 3) * 0.4),
                            DottedLine(
                              direction: Axis.vertical,
                              lineThickness: widget.profilePageStyles.widthDp * 3,
                              lineLength: widget.profilePageStyles.widthDp * 18,
                              dashLength: 2,
                              dashGapLength: 2,
                              dashColor: Color(0xFFDD4BF8),
                              dashGapColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: widget.profilePageStyles.heightDp * 25),
                Row(
                  children: [
                    Text(
                      "Incentives",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Color(0xFF00E5D4),
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Stack(
                      children: [
                        Container(
                          height: widget.profilePageStyles.lineHeight,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                            child: Container(
                              width: widget.profilePageStyles.barWidth,
                              height: widget.profilePageStyles.barHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                                color: Color(0xFF24618C),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: widget.profilePageStyles.barWidth * netWorth,
                                    height: widget.profilePageStyles.barHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 5),
                                      color: Color(0xFF00FFD7),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF00FFD7).withOpacity(0.7),
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: (widget.profilePageStyles.barWidth - widget.profilePageStyles.widthDp * 3) * 0.6),
                            Container(
                              width: widget.profilePageStyles.widthDp * 3,
                              height: widget.profilePageStyles.heightDp * 18,
                              color: Color(0xFF4D7DFC),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: (widget.profilePageStyles.barWidth - widget.profilePageStyles.widthDp * 3) * 0.3),
                            DottedLine(
                              direction: Axis.vertical,
                              lineThickness: widget.profilePageStyles.widthDp * 3,
                              lineLength: widget.profilePageStyles.widthDp * 18,
                              dashLength: 2,
                              dashGapLength: 2,
                              dashColor: Color(0xFFDD4BF8),
                              dashGapColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: widget.profilePageStyles.heightDp * 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: widget.profilePageStyles.heightDp * 12,
                          height: widget.profilePageStyles.heightDp * 12,
                          decoration: BoxDecoration(
                            color: Color(0xFF47E6C9),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: widget.profilePageStyles.widthDp * 10),
                        Text(
                          "Your Performance",
                          style: TextStyle(
                            fontSize: widget.profilePageStyles.fontSp * 12,
                            color: Color(0xFF00E5D4),
                            fontFamily: "Avenir-Book",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: widget.profilePageStyles.widthDp * 3,
                          height: widget.profilePageStyles.heightDp * 18,
                          color: Color(0xFF4D7DFC),
                        ),
                        SizedBox(width: widget.profilePageStyles.widthDp * 10),
                        Text(
                          "Average of Same stage",
                          style: TextStyle(
                            fontSize: widget.profilePageStyles.fontSp * 12,
                            color: Color(0xFF67BFFF),
                            fontFamily: "Avenir-Book",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: widget.profilePageStyles.heightDp * 10),
                Row(
                  children: [
                    DottedLine(
                      direction: Axis.vertical,
                      lineThickness: widget.profilePageStyles.widthDp * 3,
                      lineLength: widget.profilePageStyles.heightDp * 18,
                      dashLength: 2,
                      dashGapLength: 2,
                      dashColor: Color(0xFFDD4BF8),
                      dashGapColor: Colors.transparent,
                    ),
                    SizedBox(width: widget.profilePageStyles.widthDp * 10),
                    Text(
                      "Average of Next Stage",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Color(0xFFF858FF),
                        fontFamily: "Avenir-Book",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: widget.profilePageStyles.heightDp * 45),
          KeicyRaisedButton(
            width: widget.profilePageStyles.widthDp * 162,
            height: widget.profilePageStyles.heightDp * 30,
            color: Color(0xFF285773),
            borderRadius: widget.profilePageStyles.heightDp * 10,
            child: Text(
              "Stage Comparison",
              style: TextStyle(
                fontSize: widget.profilePageStyles.fontSp * 12,
                color: Color(0xFF00E5D4),
                fontFamily: "Avenir-Heavy",
              ),
            ),
          ),
          SizedBox(height: widget.profilePageStyles.heightDp * 28),
        ],
      ),
    );
  }

  Widget _containerAchievements(BuildContext context) {
    List<int> _list = List<int>.filled(13, 0, growable: true);
    int index = -1;
    return Wrap(
      spacing: widget.profilePageStyles.widthDp * 15,
      runSpacing: widget.profilePageStyles.heightDp * 12,
      children: _list.map((data) {
        index++;
        return Container(
          width: widget.profilePageStyles.widthDp * 145,
          height: widget.profilePageStyles.heightDp * 121,
          decoration: BoxDecoration(
            color: Color(0xFF87A7B8),
            borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 20),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.profilePageStyles.widthDp * 10,
            vertical: widget.profilePageStyles.heightDp * 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (index % 2 == 0)
                  ? Text(
                      "Login Dates",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Colors.white,
                        fontFamily: "Avenir-Heavy",
                      ),
                    )
                  : Text(
                      "Let’s Be Friends",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Color(0xFF004343),
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
              (index % 2 == 0)
                  ? CircularPercentIndicator(
                      radius: widget.profilePageStyles.heightDp * 65,
                      lineWidth: widget.profilePageStyles.widthDp * 5,
                      animation: false,
                      percent: 0.7,
                      center: Text(
                        "70.0%",
                        style: TextStyle(
                          fontSize: widget.profilePageStyles.fontSp * 12,
                          color: Colors.white,
                          fontFamily: "Avenir-Black",
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xFFEB9A2C),
                      backgroundColor: Colors.white,
                    )
                  : SvgPicture.asset(
                      AppAssets.circleCheckImage,
                      width: widget.profilePageStyles.heightDp * 48,
                      height: widget.profilePageStyles.heightDp * 48,
                      fit: BoxFit.cover,
                    ),
              (index % 2 == 0)
                  ? SizedBox()
                  : Text(
                      "Achieved",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Colors.white,
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _containerHelperDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            width: widget.profilePageStyles.widthDp * 250,
            height: widget.profilePageStyles.heightDp * 345,
            padding: EdgeInsets.symmetric(
              horizontal: widget.profilePageStyles.widthDp * 30,
              vertical: widget.profilePageStyles.heightDp * 30,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFA3A3A3),
              borderRadius: BorderRadius.circular(widget.profilePageStyles.heightDp * 20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tips !",
                  style: TextStyle(
                    fontSize: widget.profilePageStyles.widthDp * 37,
                    color: Colors.white,
                    fontFamily: "Avenir-Heavy",
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How well am I doing financially?",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 17,
                        color: Colors.white,
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
                    SizedBox(height: widget.profilePageStyles.heightDp * 15),
                    Text(
                      "+	     Build wealth\n+	     Stick to budget\n+     	Achieve goals",
                      style: TextStyle(
                        fontSize: widget.profilePageStyles.fontSp * 12,
                        color: Colors.white,
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
                    SizedBox(height: widget.profilePageStyles.heightDp * 30),
                  ],
                ),
                KeicyRaisedButton(
                  width: widget.profilePageStyles.widthDp * 150,
                  height: widget.profilePageStyles.heightDp * 36,
                  borderRadius: widget.profilePageStyles.heightDp * 18,
                  borderColor: Colors.white,
                  borderWidth: widget.profilePageStyles.widthDp * 2,
                  color: Color(0xFFA3A3A3),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: widget.profilePageStyles.fontSp * 16,
                      color: Colors.white,
                      fontFamily: "Avenir-Book",
                    ),
                  ),
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  double wealthGrowth;
  double netWorth;
  double incentives;

  CustomClipPath(this.wealthGrowth, this.netWorth, this.incentives);

  @override
  Path getClip(Size size) {
    var radius = size.width / 2;

    Path path = Path();
    path.moveTo(radius, radius - wealthGrowth * radius);
    path.lineTo(radius - netWorth * radius * cos(pi / 6), radius + netWorth * radius * sin(pi / 6));
    path.lineTo(radius + incentives * radius * cos(pi / 6), radius + incentives * radius * sin(pi / 6));
    path.lineTo(radius, radius - wealthGrowth * radius);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Custom1Painter extends CustomPainter {
  double wealthGrowth;
  double netWorth;
  double incentives;
  Color color;

  Custom1Painter(this.wealthGrowth, this.netWorth, this.incentives, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = size.width / 2;

    final pointMode = PointMode.polygon;
    final points = [
      Offset(radius, radius - wealthGrowth * radius),
      Offset(radius - netWorth * radius * cos(pi / 6), radius + netWorth * radius * sin(pi / 6)),
      Offset(radius + incentives * radius * cos(pi / 6), radius + incentives * radius * sin(pi / 6)),
      Offset(radius, radius - wealthGrowth * radius),
    ];
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
