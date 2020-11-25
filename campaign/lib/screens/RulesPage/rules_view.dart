import 'dart:math';
import 'dart:ui';

import 'package:campaign/screens/App/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'index.dart';

class RulesView extends StatefulWidget {
  final RulesPageStyles rulesPageStyles;

  const RulesView({
    Key key,
    this.rulesPageStyles,
  }) : super(key: key);

  @override
  _RulesViewState createState() => _RulesViewState();
}

class _RulesViewState extends State<RulesView> {
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
      body: SingleChildScrollView(
        child: Container(
          width: widget.rulesPageStyles.deviceWidth,
          height: widget.rulesPageStyles.deviceHeight,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 8, color: Color(0xFFBFD7DF)),
              right: BorderSide(width: 8, color: Color(0xFFBFD7DF)),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF00759D),
                Color(0xFF006A91),
                Color(0xFF00638D),
                Color(0xFF005D85),
              ],
              stops: [
                0,
                0.3,
                0.9,
                1,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    _containerRule1(context),
                    _containerRule2(context),
                    _containerRule3(context),
                    _containerRule4(context),
                    _containerRule5(context),
                  ],
                ),
              ),
              Container(
                width: widget.rulesPageStyles.deviceWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: widget.rulesPageStyles.heightDp * 15),
                    Container(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        effect: WormEffect(
                          dotWidth: widget.rulesPageStyles.heightDp * 10,
                          dotHeight: widget.rulesPageStyles.heightDp * 10,
                          spacing: widget.rulesPageStyles.heightDp * 6,
                          dotColor: Color(0xFF868686),
                          activeDotColor: Color(0xFF74FFF5),
                        ),
                      ),
                    ),
                    SizedBox(height: widget.rulesPageStyles.heightDp * 35),
                    KeicyRaisedButton(
                      width: widget.rulesPageStyles.widthDp * 132,
                      height: widget.rulesPageStyles.heightDp * 36,
                      borderRadius: widget.rulesPageStyles.heightDp * 18,
                      color: Color(0xFF1982AA).withOpacity(0.68),
                      elevation: 0,
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: widget.rulesPageStyles.fontSp * 16,
                          color: Colors.white,
                          fontFamily: "Avenir-Light",
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: widget.rulesPageStyles.heightDp * 55),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerRule1(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget.rulesPageStyles.deviceWidth,
        child: Stack(
          children: [
            _containerRectangles(context),
            Container(
              width: widget.rulesPageStyles.deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: widget.rulesPageStyles.widthDp * 25),
              child: Column(
                children: [
                  SizedBox(height: widget.rulesPageStyles.statusbarHeight),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  Text("RULES", style: widget.rulesPageStyles.headerStyle),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 50),
                  //////////////////////////////////////////
                  SizedBox(height: widget.rulesPageStyles.heightDp * 40),
                  Image.asset(
                    AppAssets.logtrimIcon,
                    width: widget.rulesPageStyles.widthDp * 85,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 20),
                  Text(
                    "In this challenge, the top 100\nparticipants who earn the highest\nscores among the 3 batches will\nsplit the HK\$50,000 cash prize.",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 18,
                      color: Color(0xFF74FFF5),
                      fontFamily: "Avenir-Heavy",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 30),
                  Text(
                    "Batches period",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 15,
                      color: Color(0xFF74FFF5),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "Batch 1 – 30 Nov 2020 to 20 Dec 2020\n" + "Batch 2 – 7 Dec 2020 to 4 Jan 2021\n" + "Batch 3 – 14 Dec 2020 to 11 Jan 2021",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 15,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerRule2(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget.rulesPageStyles.deviceWidth,
        child: Stack(
          children: [
            _containerRectangles(context),
            Container(
              width: widget.rulesPageStyles.deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: widget.rulesPageStyles.widthDp * 25),
              child: Column(
                children: [
                  SizedBox(height: widget.rulesPageStyles.statusbarHeight),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  Text("RULES", style: widget.rulesPageStyles.headerStyle),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 50),
                  //////////////////////////////////////////

                  Text(
                    "How to gain marks?",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 18,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 12),
                  Container(
                    width: widget.rulesPageStyles.widthDp * 233,
                    height: widget.rulesPageStyles.heightDp * 53,
                    color: Color(0xFF26A3CA),
                    child: Center(
                      child: Text(
                        "Ossey = your marks",
                        style: TextStyle(
                          fontSize: widget.rulesPageStyles.fontSp * 20,
                          color: Color(0xFF74FFF5),
                          fontFamily: "Avenir-BlackOblique",
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.rulesPageStyles.heightDp * 70,
                        height: widget.rulesPageStyles.heightDp * 50,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              AppAssets.gem1Icon,
                              width: widget.rulesPageStyles.heightDp * 45,
                              height: widget.rulesPageStyles.heightDp * 45,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: widget.rulesPageStyles.heightDp * 35,
                              top: widget.rulesPageStyles.heightDp * 15,
                              child: Container(
                                width: widget.rulesPageStyles.heightDp * 2,
                                height: widget.rulesPageStyles.heightDp * 2,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  backgroundBlendMode: BlendMode.screen,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x77D3E6E6),
                                      blurRadius: 10,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: widget.rulesPageStyles.heightDp * 7,
                        height: widget.rulesPageStyles.heightDp * 3,
                        color: Colors.white,
                      ),
                      SizedBox(width: widget.rulesPageStyles.widthDp * 25),
                      Container(
                        width: widget.rulesPageStyles.heightDp * 70,
                        height: widget.rulesPageStyles.heightDp * 50,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              AppAssets.gem1Icon,
                              width: widget.rulesPageStyles.heightDp * 45,
                              height: widget.rulesPageStyles.heightDp * 45,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Text(
                                "x10",
                                style: TextStyle(
                                  fontSize: widget.rulesPageStyles.fontSp * 22,
                                  color: Colors.white,
                                  fontFamily: "Avenir-Heavy",
                                ),
                              ),
                            ),
                            Positioned(
                              right: widget.rulesPageStyles.widthDp * 35,
                              top: widget.rulesPageStyles.widthDp * 15,
                              child: Container(
                                width: widget.rulesPageStyles.heightDp * 2,
                                height: widget.rulesPageStyles.heightDp * 2,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  backgroundBlendMode: BlendMode.screen,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x77D3E6E6),
                                      blurRadius: 10,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 20),
                  Text(
                    "You will be asked to do 5 tasks per day. You can gain marks by doing as may tasks as possible.  A maximum 10 Ossey can be earned in a day. There are two type of tasks.",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "Static task:",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "Article reading, Questionnaire, Pair up; tasks that don’t interact with your net worth, where the task score is static.",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "Dynamic task:",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "Tasks that interact with your net worth, where the task score is dynamic depending on the task value-to-net worth ratio.",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerRule3(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget.rulesPageStyles.deviceWidth,
        child: Stack(
          children: [
            _containerRectangles(context),
            Container(
              width: widget.rulesPageStyles.deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: widget.rulesPageStyles.widthDp * 25),
              child: Column(
                children: [
                  SizedBox(height: widget.rulesPageStyles.statusbarHeight),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  Text("RULES", style: widget.rulesPageStyles.headerStyle),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 50),
                  //////////////////////////////////////////

                  Text(
                    "How to gain more marks?",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 18,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 30),
                  Text(
                    "Buddy bonus:",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "If you pair up with a buddy to complete the challenge, you will earn 2x scores for the dynamic tasks. Sign of pair up tacks:",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 14),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.gem2Icon,
                        width: widget.rulesPageStyles.heightDp * 62,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        right: widget.rulesPageStyles.heightDp * 20,
                        top: widget.rulesPageStyles.heightDp * 10,
                        child: Container(
                          width: widget.rulesPageStyles.heightDp * 2,
                          height: widget.rulesPageStyles.heightDp * 2,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            backgroundBlendMode: BlendMode.screen,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x77D3E6E6),
                                blurRadius: 10,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 30),
                  Text(
                    "Double up bonus:",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 5),
                  Text(
                    "You will receive double score bonus if you finish the pair up task.\nThe sign of double scored score:",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.gem3Icon,
                        width: widget.rulesPageStyles.heightDp * 93,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        right: widget.rulesPageStyles.heightDp * 35,
                        top: widget.rulesPageStyles.heightDp * 15,
                        child: Container(
                          width: widget.rulesPageStyles.heightDp * 2,
                          height: widget.rulesPageStyles.heightDp * 2,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            backgroundBlendMode: BlendMode.screen,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x77D3E6E6),
                                blurRadius: 10,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerRule4(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget.rulesPageStyles.deviceWidth,
        child: Stack(
          children: [
            _containerRectangles(context),
            Container(
              width: widget.rulesPageStyles.deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: widget.rulesPageStyles.widthDp * 25),
              child: Column(
                children: [
                  SizedBox(height: widget.rulesPageStyles.statusbarHeight),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  Text("RULES", style: widget.rulesPageStyles.headerStyle),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 50),
                  //////////////////////////////////////////

                  Text(
                    "How to earn unrealised retrun?",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 18,
                      color: Color(0xFF10FFED),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 20),
                  Text(
                    "1 score = HK\$1.19048",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 15,
                      color: Color(0xFF1BF7E7),
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  Text(
                    "You will earn unrealised return for completing each task. The maximum unrealised return to be earned per day is HK\$23.8, hence the maximum unrealised return you earn for the whole challenge for 21 days is HK\$500.\n\nONLY the top 100 participants with highest score will turn their unrealised cash return into the cash prize. You are able to check your Ossey and unrealised return update on everyday 00:00am.\nYou can check your ranking when you click on the top left icon.",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 20),
                  SvgPicture.asset(
                    AppAssets.rankingIcon,
                    width: widget.rulesPageStyles.widthDp * 38,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 20),
                  Text(
                    "And you are able to check the task in this week by clciking the “Weekly tasks” button.",
                    style: TextStyle(
                      fontSize: widget.rulesPageStyles.fontSp * 13,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                  KeicyRaisedButton(
                    width: widget.rulesPageStyles.widthDp * 148,
                    height: widget.rulesPageStyles.heightDp * 38,
                    borderRadius: widget.rulesPageStyles.heightDp * 19,
                    color: Color(0xFF1987AE),
                    child: Text(
                      "Weekly Tasks",
                      style: TextStyle(
                        fontSize: widget.rulesPageStyles.fontSp * 16,
                        color: Color(0xFF10FFED),
                        fontFamily: "Avenir-Medium",
                      ),
                    ),
                  ),
                  SizedBox(height: widget.rulesPageStyles.heightDp * 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerRule5(BuildContext context) {
    return Container(
      width: widget.rulesPageStyles.deviceWidth,
      child: Stack(
        children: [
          _containerRectangles(context),
          Container(
            width: widget.rulesPageStyles.deviceWidth,
            padding: EdgeInsets.symmetric(horizontal: widget.rulesPageStyles.widthDp * 25),
            child: Column(
              children: [
                SizedBox(height: widget.rulesPageStyles.statusbarHeight),
                SizedBox(height: widget.rulesPageStyles.heightDp * 25),
                Text("RULES", style: widget.rulesPageStyles.headerStyle),
                SizedBox(height: widget.rulesPageStyles.heightDp * 50),
                //////////////////////////////////////////

                Expanded(
                  child: Center(
                    child: Text(
                      "Enjoy your experience,\nand be our top 100!",
                      style: TextStyle(
                        fontSize: widget.rulesPageStyles.fontSp * 20,
                        color: Color(0xFF74FFF5),
                        fontFamily: "Avenir-BlackOblique",
                        fontStyle: FontStyle.italic,
                        shadows: [
                          BoxShadow(
                            color: Color(0xFF74FFF5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      left: 0,
      top: widget.rulesPageStyles.statusbarHeight - widget.rulesPageStyles.heightDp * 30,
      child: Container(
        width: widget.rulesPageStyles.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.rectangleForRulePage,
              width: widget.rulesPageStyles.widthDp * 160,
              height: widget.rulesPageStyles.widthDp * 160,
              fit: BoxFit.fill,
            ),
            SizedBox(width: widget.rulesPageStyles.widthDp * 10),
          ],
        ),
      ),
    );
  }
}
