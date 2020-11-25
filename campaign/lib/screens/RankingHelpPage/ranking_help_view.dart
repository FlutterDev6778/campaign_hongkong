import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:campaign/screens/WeekChallengePage/week_challenge_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keicy_avatar_image/keicy_avatar_image.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../App/index.dart';

import 'index.dart';

class RankingHelpView extends StatefulWidget {
  final RankingHelpPageStyles rankingHelpPageStyles;

  const RankingHelpView({
    Key key,
    this.rankingHelpPageStyles,
  }) : super(key: key);

  @override
  _RankingHelpViewState createState() => _RankingHelpViewState();
}

class _RankingHelpViewState extends State<RankingHelpView> {
  PageController pageController;

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
        width: widget.rankingHelpPageStyles.deviceWidth,
        height: widget.rankingHelpPageStyles.deviceHeight,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: widget.rankingHelpPageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
            right: BorderSide(width: widget.rankingHelpPageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFF006A91),
              Color(0xFF00638D),
              Color(0xFF033F58),
              Color(0xFF033F58),
            ],
            stops: [
              0,
              0.28,
              0.55,
              1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _containerMain(context),
      ),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Container(
      width: widget.rankingHelpPageStyles.deviceWidth,
      height: widget.rankingHelpPageStyles.deviceHeight,
      child: Stack(
        children: [
          _containerRectangles(context),
          Column(
            children: [
              SizedBox(height: widget.rankingHelpPageStyles.statusbarHeight),
              _containerHeader(context),
              SizedBox(height: widget.rankingHelpPageStyles.heightDp * 40),
              _containerLists(context),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    KeicyRaisedButton(
                      width: widget.rankingHelpPageStyles.widthDp * 132,
                      height: widget.rankingHelpPageStyles.heightDp * 36,
                      borderRadius: widget.rankingHelpPageStyles.heightDp * 18,
                      color: Color(0xFF1982AA).withOpacity(0.68),
                      elevation: 0,
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: widget.rankingHelpPageStyles.fontSp * 16,
                          color: Colors.white,
                          fontFamily: "Avenir-Light",
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: widget.rankingHelpPageStyles.heightDp * 40),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      top: widget.rankingHelpPageStyles.statusbarHeight - widget.rankingHelpPageStyles.heightDp * 30,
      child: Container(
        width: widget.rankingHelpPageStyles.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.rectangleForRulePage,
              height: widget.rankingHelpPageStyles.heightDp * 160,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.rankingHelpPageStyles.deviceWidth,
      child: Container(
        width: widget.rankingHelpPageStyles.deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: widget.rankingHelpPageStyles.widthDp * 23),
        child: Column(
          children: [
            SizedBox(height: widget.rankingHelpPageStyles.heightDp * 25),
            Text(
              "Honour\nBadges".toUpperCase(),
              style: TextStyle(
                fontSize: widget.rankingHelpPageStyles.fontSp * 36,
                fontFamily: "Avenir-Heavy",
                color: Colors.white,
                height: 1.2,
                shadows: [
                  BoxShadow(color: Color(0xFF002623), offset: Offset(0, 3), blurRadius: 6),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerLists(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.rankingHelpPageStyles.widthDp * 30),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.firstPlaceIcon,
                width: widget.rankingHelpPageStyles.heightDp * 76,
                height: widget.rankingHelpPageStyles.heightDp * 76,
                fit: BoxFit.fill,
              ),
              SizedBox(width: widget.rankingHelpPageStyles.widthDp * 10),
              Text(
                "Top 1st honour badge",
                style: TextStyle(
                  fontSize: widget.rankingHelpPageStyles.fontSp * 18,
                  color: Colors.white,
                  fontFamily: "Avenir-BlackOblique",
                ),
              )
            ],
          ),
          SizedBox(height: widget.rankingHelpPageStyles.heightDp * 20),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.secondPlaceIcon,
                width: widget.rankingHelpPageStyles.heightDp * 76,
                height: widget.rankingHelpPageStyles.heightDp * 76,
                fit: BoxFit.fill,
              ),
              SizedBox(width: widget.rankingHelpPageStyles.widthDp * 10),
              Text(
                "Top 2nd honour badge",
                style: TextStyle(
                  fontSize: widget.rankingHelpPageStyles.fontSp * 18,
                  color: Colors.white,
                  fontFamily: "Avenir-BlackOblique",
                ),
              )
            ],
          ),
          SizedBox(height: widget.rankingHelpPageStyles.heightDp * 20),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.thirdPlaceIcon,
                width: widget.rankingHelpPageStyles.heightDp * 76,
                height: widget.rankingHelpPageStyles.heightDp * 76,
                fit: BoxFit.fill,
              ),
              SizedBox(width: widget.rankingHelpPageStyles.widthDp * 10),
              Text(
                "Top 3rd honour badge",
                style: TextStyle(
                  fontSize: widget.rankingHelpPageStyles.fontSp * 18,
                  color: Colors.white,
                  fontFamily: "Avenir-BlackOblique",
                ),
              )
            ],
          ),
          SizedBox(height: widget.rankingHelpPageStyles.heightDp * 30),
          Row(
            children: [
              Container(
                width: widget.rankingHelpPageStyles.heightDp * 76,
                height: widget.rankingHelpPageStyles.heightDp * 76,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.medal1Icon,
                    height: widget.rankingHelpPageStyles.heightDp * 56,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(width: widget.rankingHelpPageStyles.widthDp * 10),
              Text(
                "Continuing completed\n3 weeks challenge\nhonour badge",
                style: TextStyle(
                  fontSize: widget.rankingHelpPageStyles.fontSp * 18,
                  color: Colors.white,
                  fontFamily: "Avenir-BlackOblique",
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          SizedBox(height: widget.rankingHelpPageStyles.heightDp * 20),
          Row(
            children: [
              Container(
                width: widget.rankingHelpPageStyles.heightDp * 76,
                height: widget.rankingHelpPageStyles.heightDp * 76,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.medal2Icon,
                    height: widget.rankingHelpPageStyles.heightDp * 56,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(width: widget.rankingHelpPageStyles.widthDp * 10),
              Text(
                "Continuing completed\n7 days challenge\nhonour badge",
                style: TextStyle(
                  fontSize: widget.rankingHelpPageStyles.fontSp * 18,
                  color: Colors.white,
                  fontFamily: "Avenir-BlackOblique",
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RectaglePainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.polygon;
    final points = [
      Offset(0, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
      Offset(size.width, 0),
      Offset(0, 0),
    ];
    final paint = Paint()
      ..color = Color(0xFF10FFED)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  double widthDp;

  CustomClipPath();
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
