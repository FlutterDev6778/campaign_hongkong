import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/providers/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/RankingPage/index.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:campaign/screens/TodayChallengePage/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../App/index.dart';

import 'index.dart';

class WeekChallengeView extends StatefulWidget {
  final WeekChallengePageStyles weekChallengePageStyles;

  const WeekChallengeView({
    Key key,
    this.weekChallengePageStyles,
  }) : super(key: key);

  @override
  _WeekChallengeViewState createState() => _WeekChallengeViewState();
}

class _WeekChallengeViewState extends State<WeekChallengeView> {
  CompletedTasksProvider _completedTasksProvider;
  Map<String, dynamic> _completedTaskData;
  List<dynamic> _completedList;
  String _weekDay;
  int _weekNumber;
  int _dayNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompletedTasksProvider>(builder: (context, completedTasksProvider, _) {
        _completedTasksProvider = completedTasksProvider;
        if (_completedTasksProvider.completedTasksState.progressState == 2) {
          _completedTaskData = _completedTasksProvider.completedTasksState.completedTaskData["data"] ?? null;
          _completedList = (_completedTaskData != null && _completedTaskData["completed_list"] != null) ? _completedTaskData["completed_list"] : [];
          _weekDay = _completedTaskData["week_day"];
          _weekNumber = int.parse(_weekDay.substring(1, 2));
          _dayNumber = int.parse(_weekDay.substring(3));
        }

        return SingleChildScrollView(
          child: Container(
            width: widget.weekChallengePageStyles.deviceWidth,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 8, color: Color(0xFFBFD7DF)),
                right: BorderSide(width: 8, color: Color(0xFFBFD7DF)),
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
            child: Stack(
              children: [
                _containerRectangles(context),
                Column(
                  children: [
                    _containerHeader(context),
                    _containerOsseyPanel(context),
                    SizedBox(height: widget.weekChallengePageStyles.heightDp * 2),
                    _containerRealisedReturn(context),
                    _containerWeekChallengeTitle(context),
                    _containerTaskList(context),
                    _containerLockWidget(context),
                    SizedBox(height: widget.weekChallengePageStyles.heightDp * 30),
                    _containerButtons(context),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      top: widget.weekChallengePageStyles.statusbarHeight - widget.weekChallengePageStyles.heightDp * 50,
      child: Container(
        width: widget.weekChallengePageStyles.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.rectangleForRulePage,
              width: widget.weekChallengePageStyles.widthDp * 250,
              height: widget.weekChallengePageStyles.widthDp * 250,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.weekChallengePageStyles.deviceWidth,
      height: widget.weekChallengePageStyles.heightDp * 125,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: widget.weekChallengePageStyles.widthDp * 23),
        child: Column(
          children: [
            SizedBox(height: widget.weekChallengePageStyles.statusbarHeight),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RankingPage()));
                      },
                      child: SvgPicture.asset(
                        AppAssets.rankingIcon,
                        width: widget.weekChallengePageStyles.heightDp * 35,
                        height: widget.weekChallengePageStyles.heightDp * 35,
                      ),
                    ),
                    Text(
                      "This Week\nchallenge".toUpperCase(),
                      style: TextStyle(
                        fontSize: widget.weekChallengePageStyles.fontSp * 29,
                        fontFamily: "Avenir-Heavy",
                        color: Colors.white,
                        height: 1,
                        shadows: [
                          BoxShadow(color: Color(0xFF002623), offset: Offset(0, 3), blurRadius: 6),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RulesPage()));
                      },
                      child: Container(
                        width: widget.weekChallengePageStyles.heightDp * 35,
                        height: widget.weekChallengePageStyles.heightDp * 35,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF269FC3)),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.helpIcon,
                            width: widget.weekChallengePageStyles.heightDp * 20,
                            height: widget.weekChallengePageStyles.heightDp * 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerOsseyPanel(BuildContext context) {
    return Container(
      width: widget.weekChallengePageStyles.deviceWidth,
      height: widget.weekChallengePageStyles.heightDp * 53,
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
              fontSize: widget.weekChallengePageStyles.fontSp * 29,
              fontFamily: "Avenir-BlackOblique",
              height: 1.3,
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Ossey",
            style: TextStyle(
              fontSize: widget.weekChallengePageStyles.fontSp * 29,
              fontFamily: "Avenir-BlackOblique",
              height: 1.3,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _containerRealisedReturn(BuildContext context) {
    return Container(
      width: widget.weekChallengePageStyles.deviceWidth,
      height: widget.weekChallengePageStyles.heightDp * 35,
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
              fontSize: widget.weekChallengePageStyles.fontSp * 18,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Unrealised return",
            style: TextStyle(
              fontSize: widget.weekChallengePageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _containerWeekChallengeTitle(BuildContext context) {
    return Container(
      width: widget.weekChallengePageStyles.deviceWidth,
      height: widget.weekChallengePageStyles.heightDp * 29,
      child: Column(
        children: [
          SizedBox(height: widget.weekChallengePageStyles.heightDp * 5),
          Text(
            "Next update time: 12/10 00:00am",
            style: TextStyle(
              fontSize: widget.weekChallengePageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFFB5B5B5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerTaskList(BuildContext context) {
    List<Map<String, dynamic>> taskData = [
      {
        "index": 0,
        "description": "5 baby steps to build saving habit",
      },
      {
        "index": 1,
        "description": "Set up a system to track your money",
      },
      {
        "index": 2,
        "description": "Turn savings into a game to stash away more money",
      },
      {
        "index": 3,
        "description": "Invite a buddy to build a healthy financial habit together",
      },
      {
        "index": 4,
        "description": "Compare your financial welbeing with peers",
      },
      {
        "index": 5,
        "description": "Set up short-term financial goals",
      },
      {
        "index": 6,
        "description": "Establish & review your retirment plan",
      },
    ];
    return Column(
      children: [
        Text(
          "${_weekNumber}ST WEEK",
          style: TextStyle(
            fontSize: widget.weekChallengePageStyles.fontSp * 26,
            color: Colors.white,
            fontFamily: "Avenir-LightOblique",
            shadows: [
              BoxShadow(
                color: Color(0xFFE6E6E6).withOpacity(0.67),
                offset: Offset(0, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        SizedBox(height: widget.weekChallengePageStyles.heightDp * 20),
        Column(
          children: taskData.map((data) {
            int _completedTaskListCount = _dayNumber > data["index"] + 1 ? 5 : _dayNumber == data["index"] + 1 ? _completedList.length : 0;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: widget.weekChallengePageStyles.widthDp * 30),
              height: widget.weekChallengePageStyles.heightDp * 145,
              child: Row(
                children: [
                  Container(
                    width: widget.weekChallengePageStyles.widthDp * 20,
                    child: Column(
                      children: [
                        _dayNumber >= data["index"] + 1
                            ? Container(
                                width: widget.weekChallengePageStyles.heightDp * 20,
                                height: widget.weekChallengePageStyles.heightDp * 20,
                                decoration: BoxDecoration(
                                    color: Color(0xFF10FFED),
                                    border: Border.all(width: widget.weekChallengePageStyles.widthDp * 3, color: Color(0xFFFBFF98)),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF64F3FF).withOpacity(0.53),
                                        offset: Offset(0, 3),
                                        blurRadius: 10,
                                      )
                                    ]),
                              )
                            : Container(
                                width: widget.weekChallengePageStyles.widthDp * 16,
                                height: widget.weekChallengePageStyles.widthDp * 16,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(width: widget.weekChallengePageStyles.widthDp * 3, color: Color(0xFFD9D9D9)),
                                  shape: BoxShape.circle,
                                ),
                              ),
                        Expanded(
                          child: Container(
                            width: widget.weekChallengePageStyles.widthDp * 2,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: widget.weekChallengePageStyles.widthDp * 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data["index"] + 1}ST day challenge",
                          style: TextStyle(
                            fontSize: widget.weekChallengePageStyles.fontSp * 16,
                            color: _dayNumber == data["index"] + 1
                                ? Color(0xFF74FFF5)
                                : _dayNumber < data["index"] + 1 ? Colors.white : Color(0xFF2F2F2F),
                            fontFamily: "Avenir-Heavy",
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              data["description"],
                              style: TextStyle(
                                fontSize: widget.weekChallengePageStyles.fontSp * 12,
                                color: _dayNumber == data["index"] + 1
                                    ? Color(0xFF74FFF5)
                                    : _dayNumber < data["index"] + 1 ? Colors.white : Color(0xFF2F2F2F),
                                fontFamily: "Avenir-Heavy",
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          height: widget.weekChallengePageStyles.heightDp * 20,
                          decoration: BoxDecoration(
                            color: (_dayNumber >= data["index"] + 1) ? Color(0xFF15EBD9).withOpacity(0.4) : Color(0xFF2E2E2E),
                            border: Border.all(
                              color: (_dayNumber >= data["index"] + 1) ? Color(0xFF00FFE3) : Colors.transparent,
                              width: 0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: _completedTaskListCount,
                                    child: Container(color: Color(0xFF00FFE3)),
                                  ),
                                  Expanded(
                                    flex: 5 - _completedTaskListCount,
                                    child: Container(
                                      color: Colors.transparent,
                                      height: widget.weekChallengePageStyles.heightDp * 20,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: widget.weekChallengePageStyles.heightDp * 20,
                                alignment: Alignment.center,
                                child: Text(
                                  "$_completedTaskListCount/5 tasks",
                                  style: TextStyle(
                                    fontSize: widget.weekChallengePageStyles.widthDp * 11,
                                    color: _completedTaskListCount >= 3 ? Color(0xFF2E2E2E) : Colors.white,
                                    fontFamily: "Avenir-Heavy",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: widget.weekChallengePageStyles.heightDp * 10),
                        KeicyRaisedButton(
                          width: widget.weekChallengePageStyles.widthDp * 132,
                          height: widget.weekChallengePageStyles.heightDp * 35,
                          borderRadius: widget.weekChallengePageStyles.heightDp * 18,
                          color: (_dayNumber == data["index"] + 1)
                              ? Color(0xFF1990B8)
                              : (_dayNumber >= data["index"] + 1) ? Colors.black.withOpacity(0.2) : Colors.transparent,
                          borderColor: (_dayNumber >= data["index"] + 1) ? Colors.transparent : Colors.white,
                          elevation: 0,
                          child: Text(
                            _dayNumber > data["index"] + 1 ? "Done" : _dayNumber == data["index"] + 1 ? "In Progress" : "Locked",
                            style: TextStyle(
                              fontSize: widget.weekChallengePageStyles.fontSp * 16,
                              color: (_dayNumber >= data["index"] + 1) ? Color(0xFF10FFED) : Colors.white,
                              fontFamily: "Avenir-Medium",
                            ),
                          ),
                          onPressed: !(_dayNumber == data["index"] + 1)
                              ? null
                              : () {
                                  // if (data["status"] == "Locked") return;
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                        ),
                        SizedBox(height: widget.weekChallengePageStyles.heightDp * 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: widget.weekChallengePageStyles.widthDp * 30),
          child: Row(
            children: [
              Container(
                width: widget.weekChallengePageStyles.heightDp * 20,
                height: widget.weekChallengePageStyles.heightDp * 20,
                decoration: BoxDecoration(
                  color: Color(0xFF0E282F),
                  border: Border.all(width: 3, color: Colors.white),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: widget.weekChallengePageStyles.widthDp * 20),
              Expanded(
                child: Text(
                  "Unlock the First 7 days bonus!",
                  style: TextStyle(
                    fontSize: widget.weekChallengePageStyles.fontSp * 16,
                    color: Color(0xFF818181),
                    fontFamily: "Avenir-Heavy",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _containerLockWidget(BuildContext context) {
    return Image.asset(
      AppAssets.lockImg,
      width: widget.weekChallengePageStyles.heightDp * 190,
      height: widget.weekChallengePageStyles.heightDp * 190,
      fit: BoxFit.cover,
    );
    //   return Container(
    //     width: widget.weekChallengePageStyles.heightDp * 190,
    //     height: widget.weekChallengePageStyles.heightDp * 190,
    //     decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    //     child: Stack(
    //       children: [
    //         SvgPicture.asset(
    //           AppAssets.fireKeyBack1Img,
    //           width: widget.weekChallengePageStyles.heightDp * 190,
    //           height: widget.weekChallengePageStyles.heightDp * 190,
    //           fit: BoxFit.cover,
    //         ),
    //         Positioned(
    //           top: widget.weekChallengePageStyles.heightDp * 40,
    //           child: Container(
    //             width: widget.weekChallengePageStyles.heightDp * 190,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Opacity(
    //                   opacity: 0.9,
    //                   child: Image.asset(
    //                     AppAssets.firebackImg,
    //                     width: widget.weekChallengePageStyles.heightDp * 120,
    //                     height: widget.weekChallengePageStyles.heightDp * 120,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 SizedBox(width: widget.weekChallengePageStyles.heightDp * 15),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: widget.weekChallengePageStyles.heightDp * 90,
    //           child: Opacity(
    //             opacity: 0.73,
    //             child: Container(
    //               width: widget.weekChallengePageStyles.heightDp * 190,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   SvgPicture.asset(
    //                     AppAssets.keyIcon,
    //                     width: widget.weekChallengePageStyles.heightDp * 50,
    //                     height: widget.weekChallengePageStyles.heightDp * 50,
    //                     fit: BoxFit.fill,
    //                   ),
    //                   SizedBox(width: widget.weekChallengePageStyles.heightDp * 15),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }

  Widget _containerButtons(BuildContext context) {
    return Column(
      children: [
        KeicyRaisedButton(
          width: widget.weekChallengePageStyles.widthDp * 148,
          height: widget.weekChallengePageStyles.heightDp * 38,
          borderRadius: widget.weekChallengePageStyles.heightDp * 19,
          color: Color(0xFF1B5F7B),
          elevation: 0,
          child: Text(
            "Today Tasks",
            style: TextStyle(
              fontSize: widget.weekChallengePageStyles.fontSp * 16,
              color: Color(0xFF10FFED),
              fontFamily: "Avenir-Medium",
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => TodayChallengePage()));
          },
        ),
        SizedBox(height: widget.weekChallengePageStyles.heightDp * 28),
        KeicyRaisedButton(
          width: widget.weekChallengePageStyles.widthDp * 148,
          height: widget.weekChallengePageStyles.widthDp * 38,
          borderRadius: widget.weekChallengePageStyles.heightDp * 19,
          color: Color(0xFF1B5974),
          elevation: 0,
          child: Text(
            "Close",
            style: TextStyle(
              fontSize: widget.weekChallengePageStyles.fontSp * 17,
              color: Colors.white,
              fontFamily: "Avenir-Light",
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(height: widget.weekChallengePageStyles.heightDp * 45),
      ],
    );
  }
}
