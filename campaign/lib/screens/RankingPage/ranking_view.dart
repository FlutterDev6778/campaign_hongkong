import 'dart:math';
import 'dart:ui';

import 'package:campaign/screens/RankingHelpPage/index.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keicy_avatar_image/keicy_avatar_image.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../App/index.dart';
import '../../providers/index.dart';

import 'index.dart';

class RankingView extends StatefulWidget {
  final RankingPageStyles rankingPageStyles;

  const RankingView({
    Key key,
    this.rankingPageStyles,
  }) : super(key: key);

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  PageController pageController;
  CustomPopupMenuController _popUpMenuController = CustomPopupMenuController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  int _category;
  double _rankValue;
  double _osseyValue;
  int _userIndex;
  Map<String, dynamic> _completedTaskData;

  CompletedTasksProvider _completedTasksProvider;

  @override
  void initState() {
    super.initState();

    pageController = new PageController();
    _category = 0;
    _rankValue = 0.0;
    _osseyValue = 0.0;
    _userIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompletedTasksProvider>(builder: (context, completedTasksProvider, _) {
      _completedTasksProvider = completedTasksProvider;
      if (!completedTasksProvider.completedTasksState.completedTaskData["success"]) {
        completedTasksProvider.getCompletedTasksData();
      } else {
        _completedTaskData = _completedTasksProvider.completedTasksState.completedTaskData["data"];
      }
      _osseyValue = _category == 0
          ? double.parse(_completedTaskData["overall_ranking_msg"].toString().split(" ")[2])
          : double.parse(_completedTaskData["cohort_ranking_msg"].toString().split(" ")[2]);

      _rankValue = _category == 0
          ? double.parse(_completedTaskData["tri_overall_msg"].toString().split(" ").last.replaceAll("%", ""))
          : double.parse(_completedTaskData["tri_cohort_msg"].toString().split(" ").last.replaceAll("%", ""));

      _userIndex = _category == 0 ? _completedTaskData["ranking_overall"] : _completedTaskData["ranking_cohort"];

      // if (pageController.page == 1) {
      //   itemScrollController.jumpTo(index: _rankValue - 1 < 0 ? 0 : _rankValue - 1);
      // }

      return Scaffold(
        body: Container(
          width: widget.rankingPageStyles.deviceWidth,
          height: widget.rankingPageStyles.deviceHeight,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 8, color: Color(0xFFBFD7DF)),
              right: BorderSide(width: 8, color: Color(0xFFBFD7DF)),
            ),
            gradient: RankingPageColors.backGradient,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                _containerRectangles(context),
                Column(
                  children: [
                    _containerHeader(context),
                    _containerOsseyPanel(context),
                    SizedBox(height: widget.rankingPageStyles.heightDp * 2),
                    _containerRealisedReturn(context),
                    _containerNextTime(context),
                    Container(
                      height: widget.rankingPageStyles.mainPanelHeight + widget.rankingPageStyles.heightDp * 90,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        children: [
                          _containerUserLevel(context),
                          _containerUserList(context),
                        ],
                      ),
                    ),
                    SizedBox(height: widget.rankingPageStyles.heightDp * 36),
                    Container(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 2,
                        effect: WormEffect(
                          dotWidth: widget.rankingPageStyles.heightDp * 10,
                          dotHeight: widget.rankingPageStyles.heightDp * 10,
                          spacing: widget.rankingPageStyles.heightDp * 6,
                          dotColor: Color(0xFF868686),
                          activeDotColor: Color(0xFF74FFF5),
                        ),
                      ),
                    ),
                    SizedBox(height: widget.rankingPageStyles.heightDp * 60),
                    KeicyRaisedButton(
                      width: widget.rankingPageStyles.widthDp * 132,
                      height: widget.rankingPageStyles.heightDp * 36,
                      borderRadius: widget.rankingPageStyles.heightDp * 18,
                      color: Color(0xFF1982AA).withOpacity(0.68),
                      elevation: 0,
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: widget.rankingPageStyles.fontSp * 16,
                          color: Colors.white,
                          fontFamily: "Avenir-Light",
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: widget.rankingPageStyles.heightDp * 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      top: widget.rankingPageStyles.statusbarHeight - widget.rankingPageStyles.heightDp * 30,
      child: Container(
        width: widget.rankingPageStyles.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.rectangleForRulePage,
              height: widget.rankingPageStyles.heightDp * 160,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerUserLevel(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.rankingPageStyles.deviceWidth,
          height: widget.rankingPageStyles.mainPanelHeight,
          padding: EdgeInsets.symmetric(horizontal: widget.rankingPageStyles.widthDp * 10),
          child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: widget.rankingPageStyles.widthDp * 200,
                          height: widget.rankingPageStyles.heightDp * 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.rankingPageStyles.heightDp * 2),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF03746C).withOpacity(0.0),
                                Color(0xFF74FFF5),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.rankingPageStyles.heightDp * 8 +
                          widget.rankingPageStyles.heightDp * 355 * (100 - (_rankValue > 100 ? 100 : _rankValue)) / 100,
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.rankingPageStyles.deviceWidth,
                height: widget.rankingPageStyles.mainPanelHeight,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppAssets.rankGraphImage,
                  width: widget.rankingPageStyles.widthDp * 300,
                  height: widget.rankingPageStyles.mainPanelHeight,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: widget.rankingPageStyles.deviceWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "You $_rankValue%",
                      style: TextStyle(
                        fontSize: widget.rankingPageStyles.fontSp * 17,
                        color: Colors.white,
                        fontFamily: "Avenir-Heavy",
                        shadows: [
                          BoxShadow(
                            color: Color(0xFF00FFF5).withOpacity(0.86),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: widget.rankingPageStyles.heightDp * 10),
                    SizedBox(
                      height: widget.rankingPageStyles.heightDp * 8 +
                          widget.rankingPageStyles.heightDp * 355 * (100 - (_rankValue > 100 ? 100 : _rankValue)) / 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: widget.rankingPageStyles.heightDp * 10),
        Container(
          width: widget.rankingPageStyles.deviceWidth,
          height: widget.rankingPageStyles.heightDp * 80,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                width: widget.rankingPageStyles.widthDp * 5,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF002845),
                Color(0xFF003862),
                Color(0xFF0765AA),
                Color(0xFF002641),
                Color(0xFF001524),
              ],
              stops: [0, 0.1, 0.5, 0.9, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your are on ",
                    style: TextStyle(
                      fontSize: widget.rankingPageStyles.fontSp * 16,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                    ),
                  ),
                  Text(
                    "$_rankValue%",
                    style: TextStyle(
                      fontSize: widget.rankingPageStyles.fontSp * 16,
                      color: Color(0xFF74FFF5),
                      fontFamily: "Avenir-BlackOblique",
                    ),
                  )
                ],
              ),
              SizedBox(height: widget.rankingPageStyles.heightDp * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "until next level ",
                    style: TextStyle(
                      fontSize: widget.rankingPageStyles.fontSp * 16,
                      color: Colors.white,
                      fontFamily: "Avenir-BlackOblique",
                    ),
                  ),
                  Text(
                    "$_osseyValue Ossey",
                    style: TextStyle(
                      fontSize: widget.rankingPageStyles.fontSp * 16,
                      color: Color(0xFF74FFF5),
                      fontFamily: "Avenir-BlackOblique",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _containerUserList(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: widget.rankingPageStyles.heightDp * 20),
        Container(
          width: widget.rankingPageStyles.deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: widget.rankingPageStyles.widthDp * 20),
          alignment: Alignment.center,
          child: Text(
            "Top 100 users",
            style: TextStyle(
              fontSize: widget.rankingPageStyles.widthDp * 10,
              color: Color(0xFF74FFF5),
              fontFamily: "Avenir-Heavy",
            ),
          ),
        ),
        SizedBox(height: widget.rankingPageStyles.heightDp * 8),
        Expanded(
          child: ScrollablePositionedList.separated(
            padding: EdgeInsets.zero,
            itemCount: 100,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            initialScrollIndex: (_userIndex > 100 ? 100 : _userIndex),
            itemBuilder: (context, index) {
              Widget _placeWidget = ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: widget.rankingPageStyles.heightDp * 88,
                  height: widget.rankingPageStyles.heightDp * 65,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.51,
                        child: Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: widget.rankingPageStyles.heightDp * 88,
                        height: widget.rankingPageStyles.heightDp * 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: widget.rankingPageStyles.fontSp * 24,
                                color: Colors.white,
                                fontFamily: "Avenir-HeavyOblique",
                              ),
                            ),
                            SizedBox(width: widget.rankingPageStyles.heightDp * 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

              if (index == 0) {
                _placeWidget = ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: widget.rankingPageStyles.heightDp * 88,
                    height: widget.rankingPageStyles.heightDp * 65,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.51,
                          child: Container(
                            width: widget.rankingPageStyles.heightDp * 88,
                            height: widget.rankingPageStyles.heightDp * 65,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF7B6F3C), Color(0xFFEECF27)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          child: Row(
                            children: [
                              SizedBox(width: widget.rankingPageStyles.heightDp * 8),
                              SvgPicture.asset(
                                AppAssets.firstPlaceIcon,
                                width: widget.rankingPageStyles.heightDp * 50,
                                height: widget.rankingPageStyles.heightDp * 50,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: widget.rankingPageStyles.fontSp * 24,
                                  color: Color(0xFFF7E135),
                                  fontFamily: "Avenir-HeavyOblique",
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.51),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: widget.rankingPageStyles.heightDp * 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (index == 1) {
                _placeWidget = ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: widget.rankingPageStyles.heightDp * 88,
                    height: widget.rankingPageStyles.heightDp * 65,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.51,
                          child: Container(
                            width: widget.rankingPageStyles.heightDp * 88,
                            height: widget.rankingPageStyles.heightDp * 65,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF393939), Color(0xFF9A9797)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          child: Row(
                            children: [
                              SizedBox(width: widget.rankingPageStyles.heightDp * 8),
                              SvgPicture.asset(
                                AppAssets.secondPlaceIcon,
                                width: widget.rankingPageStyles.heightDp * 50,
                                height: widget.rankingPageStyles.heightDp * 50,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: widget.rankingPageStyles.fontSp * 24,
                                  color: Color(0xFFD8D8D8),
                                  fontFamily: "Avenir-HeavyOblique",
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.51),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: widget.rankingPageStyles.heightDp * 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (index == 2) {
                _placeWidget = ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: widget.rankingPageStyles.heightDp * 88,
                    height: widget.rankingPageStyles.heightDp * 65,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.74,
                          child: Container(
                            width: widget.rankingPageStyles.heightDp * 88,
                            height: widget.rankingPageStyles.heightDp * 65,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF511900), Color(0xFFE05415)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          child: Row(
                            children: [
                              SizedBox(width: widget.rankingPageStyles.heightDp * 8),
                              SvgPicture.asset(
                                AppAssets.thirdPlaceIcon,
                                width: widget.rankingPageStyles.heightDp * 50,
                                height: widget.rankingPageStyles.heightDp * 50,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.rankingPageStyles.heightDp * 88,
                          height: widget.rankingPageStyles.heightDp * 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: widget.rankingPageStyles.fontSp * 24,
                                  color: Color(0xFFD87521),
                                  fontFamily: "Avenir-HeavyOblique",
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.51),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: widget.rankingPageStyles.heightDp * 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                width: widget.rankingPageStyles.deviceWidth,
                height: widget.rankingPageStyles.heightDp * 65,
                color: Color(0xFFCBFFFB).withOpacity(0.32),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: 0.45,
                          child: Container(
                            width: widget.rankingPageStyles.widthDp * 210,
                            height: widget.rankingPageStyles.heightDp * 65,
                            margin: EdgeInsets.symmetric(vertical: widget.rankingPageStyles.heightDp * 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFFFFFF), Color(0xFF808080).withOpacity(0)],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _placeWidget,
                        SizedBox(width: widget.rankingPageStyles.widthDp * 10),
                        KeicyAvatarImage(
                          url: "",
                          userName: "UserName",
                          width: widget.rankingPageStyles.heightDp * 45,
                          height: widget.rankingPageStyles.heightDp * 45,
                          borderRadius: widget.rankingPageStyles.heightDp * 23,
                          backColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: widget.rankingPageStyles.fontSp * 16,
                        ),
                        SizedBox(width: widget.rankingPageStyles.widthDp * 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "HKD 1030",
                                    style: TextStyle(
                                      fontSize: widget.rankingPageStyles.fontSp * 12,
                                      color: Color(0xFF10FFED),
                                      fontFamily: "Avenir-BlackOblique",
                                    ),
                                  ),
                                  Text(
                                    " Unrealised return",
                                    style: TextStyle(
                                      fontSize: widget.rankingPageStyles.fontSp * 12,
                                      color: Color(0xFF021D43),
                                      fontFamily: "Avenir-BlackOblique",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: widget.rankingPageStyles.heightDp * 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.medal1Icon,
                                    height: widget.rankingPageStyles.heightDp * 31,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(width: widget.rankingPageStyles.heightDp * 5),
                                  SvgPicture.asset(
                                    AppAssets.medal2Icon,
                                    height: widget.rankingPageStyles.heightDp * 31,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(width: widget.rankingPageStyles.heightDp * 10),
                                  Text(
                                    "100",
                                    style: TextStyle(
                                      fontSize: widget.rankingPageStyles.fontSp * 12,
                                      color: Color(0xFF10FFED),
                                      fontFamily: "Avenir-BlackOblique",
                                    ),
                                  ),
                                  Text(
                                    " EXP",
                                    style: TextStyle(
                                      fontSize: widget.rankingPageStyles.fontSp * 12,
                                      color: Color(0xFF021D43),
                                      fontFamily: "Avenir-BlackOblique",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: widget.rankingPageStyles.widthDp * 10),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(height: widget.rankingPageStyles.heightDp * 7);
            },
          ),
        ),
        SizedBox(height: widget.rankingPageStyles.heightDp * 10),
        Container(
          width: widget.rankingPageStyles.deviceWidth,
          height: widget.rankingPageStyles.heightDp * 80,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                width: widget.rankingPageStyles.widthDp * 5,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF002845),
                Color(0xFF003862),
                Color(0xFF0765AA),
                Color(0xFF002641),
                Color(0xFF001524),
              ],
              stops: [0, 0.1, 0.5, 0.9, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "You need ",
                          style: TextStyle(
                            fontSize: widget.rankingPageStyles.fontSp * 16,
                            color: Colors.white,
                            fontFamily: "Avenir-BlackOblique",
                          ),
                        ),
                        TextSpan(
                          text: "$_osseyValue Ossey",
                          style: TextStyle(
                            fontSize: widget.rankingPageStyles.fontSp * 16,
                            color: Color(0xFF74FFF5),
                            fontFamily: "Avenir-BlackOblique",
                          ),
                        ),
                        TextSpan(
                          text: " to reach the\nranking list.",
                          style: TextStyle(
                            fontSize: widget.rankingPageStyles.fontSp * 16,
                            color: Colors.white,
                            fontFamily: "Avenir-BlackOblique",
                          ),
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
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.rankingPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: widget.rankingPageStyles.widthDp * 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widget.rankingPageStyles.heightDp * 35,
            height: widget.rankingPageStyles.heightDp * 35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: widget.rankingPageStyles.statusbarHeight),
              SizedBox(height: widget.rankingPageStyles.heightDp * 10),
              Text(
                "Ranking".toUpperCase(),
                style: TextStyle(
                  fontSize: widget.rankingPageStyles.fontSp * 36,
                  fontFamily: "Avenir-Heavy",
                  color: Colors.white,
                  height: 1,
                  shadows: [
                    BoxShadow(color: Color(0xFF002623), offset: Offset(0, 3), blurRadius: 6),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: widget.rankingPageStyles.heightDp * 5),
              CustomPopupMenu(
                controller: _popUpMenuController,
                verticalMargin: -widget.rankingPageStyles.heightDp * 28,
                arrowColor: Colors.transparent,
                arrowSize: 0,
                showArrow: false,
                barrierColor: Colors.transparent,
                menuBuilder: () => Container(
                  width: widget.rankingPageStyles.widthDp * 198,
                  height: widget.rankingPageStyles.heightDp * 56,
                  decoration: BoxDecoration(
                    color: Color(0xFF00CCBD),
                    borderRadius: BorderRadius.circular(widget.rankingPageStyles.heightDp * 10),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: widget.rankingPageStyles.widthDp * 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _popUpMenuController.hideMenu();
                          if (_category != 0) {
                            setState(() {
                              _category = 0;
                              if (pageController.page == 1) {
                                itemScrollController.jumpTo(
                                    index: (_rankValue > 100 ? 100 : _rankValue) - 1 < 0 ? 0 : (_rankValue > 100 ? 100 : _rankValue) - 1);
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "21 days Challenge",
                              style: TextStyle(
                                fontSize: widget.rankingPageStyles.fontSp * 17,
                                color: Colors.white,
                                fontFamily: "Avenir-Heavy",
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _popUpMenuController.hideMenu();
                          if (_category != 1) {
                            setState(() {
                              _category = 1;
                              if (pageController.page == 1) {
                                itemScrollController.jumpTo(
                                    index: (_rankValue > 100 ? 100 : _rankValue) - 1 < 0 ? 0 : (_rankValue > 100 ? 100 : _rankValue) - 1);
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "7 days Challenge",
                              style: TextStyle(
                                fontSize: widget.rankingPageStyles.fontSp * 17,
                                color: Colors.white,
                                fontFamily: "Avenir-Heavy",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pressType: PressType.singleClick,
                child: Container(
                  width: widget.rankingPageStyles.widthDp * 198,
                  height: widget.rankingPageStyles.heightDp * 28,
                  decoration: BoxDecoration(
                    color: Color(0xFF00CCBD).withOpacity(0.81),
                    borderRadius: BorderRadius.circular(widget.rankingPageStyles.heightDp * 28),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: widget.rankingPageStyles.widthDp * 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.keyboard_arrow_down, size: widget.rankingPageStyles.heightDp * 25, color: Colors.transparent),
                      Text(
                        _category == 0 ? "21 days Challenge" : "7 days Challenge",
                        style: TextStyle(
                          fontSize: widget.rankingPageStyles.fontSp * 17,
                          color: Colors.white,
                          fontFamily: "Avenir-Heavy",
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, size: widget.rankingPageStyles.heightDp * 25, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: widget.rankingPageStyles.heightDp * 7),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RankingHelpPage()));
            },
            child: Container(
              width: widget.rankingPageStyles.heightDp * 35,
              height: widget.rankingPageStyles.heightDp * 35,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF269FC3)),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.helpIcon,
                  width: widget.rankingPageStyles.widthDp * 20,
                  height: widget.rankingPageStyles.widthDp * 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerOsseyPanel(BuildContext context) {
    return Container(
      width: widget.rankingPageStyles.deviceWidth,
      height: widget.rankingPageStyles.heightDp * 53,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1C0000),
            Color(0xFF0041D5),
            Color(0xFF121212),
          ],
          stops: [0, 0.5, 1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (_completedTaskData != null && _completedTaskData["score"] != null) ? _completedTaskData["score"].toString() : "0",
            style: TextStyle(
              fontSize: widget.rankingPageStyles.fontSp * 29,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Ossey",
            style: TextStyle(
              fontSize: widget.rankingPageStyles.fontSp * 29,
              fontFamily: "Avenir-BlackOblique",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _containerRealisedReturn(BuildContext context) {
    return Container(
      width: widget.rankingPageStyles.deviceWidth,
      height: widget.rankingPageStyles.heightDp * 38,
      color: Color(0xFF1C9AC3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "HKD " +
                ((_completedTaskData != null && _completedTaskData["unrealised_return"] != null)
                    ? _completedTaskData["unrealised_return"].toString()
                    : "0"),
            style: TextStyle(
              fontSize: widget.rankingPageStyles.fontSp * 18,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Unrealised return",
            style: TextStyle(
              fontSize: widget.rankingPageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _containerNextTime(BuildContext context) {
    return Container(
      width: widget.rankingPageStyles.deviceWidth,
      height: widget.rankingPageStyles.heightDp * 29,
      padding: EdgeInsets.symmetric(horizontal: widget.rankingPageStyles.widthDp * 10),
      child: Column(
        children: [
          SizedBox(height: widget.rankingPageStyles.heightDp * 5),
          Text(
            "Next update time: 12/10 00:00am",
            style: TextStyle(
              fontSize: widget.rankingPageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFFB5B5B5),
            ),
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
