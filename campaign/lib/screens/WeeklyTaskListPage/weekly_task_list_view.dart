import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/providers/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/RankingPage/index.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:campaign/screens/TodayChallengePage/index.dart';
import 'package:campaign/screens/WeekChallengePage/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../App/index.dart';

import 'index.dart';

class WeeklyTaskListView extends StatefulWidget {
  final WeeklyTaskListPageStyles weeklyTaskListPageStyles;
  final String weekDay;

  const WeeklyTaskListView({
    Key key,
    this.weeklyTaskListPageStyles,
    this.weekDay,
  }) : super(key: key);

  @override
  _WeeklyTaskListViewState createState() => _WeeklyTaskListViewState();
}

class _WeeklyTaskListViewState extends State<WeeklyTaskListView> {
  CompletedTasksProvider _completedTasksProvider;
  Map<String, dynamic> _completedTaskData;
  List<dynamic> _completedList;
  String _weekDay;
  int _weekNumber;

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
        }
        return Container(
          width: widget.weeklyTaskListPageStyles.deviceWidth,
          height: widget.weeklyTaskListPageStyles.deviceHeight,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: widget.weeklyTaskListPageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
              right: BorderSide(width: widget.weeklyTaskListPageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF006C94),
                Color(0xFF00779F),
                Color(0xFF00638D),
                Color(0xFF005D84),
              ],
              stops: [
                0,
                0.35,
                0.9,
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
                  SizedBox(height: widget.weeklyTaskListPageStyles.heightDp * 2),
                  _containerRealisedReturn(context),
                  _containerWeeklyTaskListTitle(context),
                  _containerTaskList(context),
                  Expanded(child: _containerButtons(context)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      top: widget.weeklyTaskListPageStyles.statusbarHeight - widget.weeklyTaskListPageStyles.heightDp * 40,
      child: Container(
        width: widget.weeklyTaskListPageStyles.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.rectangleForRulePage,
              width: widget.weeklyTaskListPageStyles.widthDp * 150,
              height: widget.weeklyTaskListPageStyles.widthDp * 150,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.weeklyTaskListPageStyles.deviceWidth,
      height: widget.weeklyTaskListPageStyles.heightDp * 125,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: widget.weeklyTaskListPageStyles.widthDp * 23),
        child: Column(
          children: [
            SizedBox(height: widget.weeklyTaskListPageStyles.statusbarHeight),
            Expanded(
              child: Center(
                child: Container(
                  width: widget.weeklyTaskListPageStyles.deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RankingPage()));
                        },
                        child: Container(
                          width: widget.weeklyTaskListPageStyles.heightDp * 35,
                          height: widget.weeklyTaskListPageStyles.heightDp * 35,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.rankingIcon,
                              width: widget.weeklyTaskListPageStyles.heightDp * 35,
                              height: widget.weeklyTaskListPageStyles.heightDp * 35,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "weekly\nTasks List".toUpperCase(),
                        style: TextStyle(
                          fontSize: widget.weeklyTaskListPageStyles.fontSp * 29,
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
                          width: widget.weeklyTaskListPageStyles.heightDp * 35,
                          height: widget.weeklyTaskListPageStyles.heightDp * 35,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF269FC3)),
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.helpIcon,
                              width: widget.weeklyTaskListPageStyles.heightDp * 20,
                              height: widget.weeklyTaskListPageStyles.heightDp * 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
      width: widget.weeklyTaskListPageStyles.deviceWidth,
      height: widget.weeklyTaskListPageStyles.heightDp * 53,
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
              fontSize: widget.weeklyTaskListPageStyles.fontSp * 29,
              fontFamily: "Avenir-BlackOblique",
              height: 1.3,
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Ossey",
            style: TextStyle(
              fontSize: widget.weeklyTaskListPageStyles.fontSp * 29,
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
      width: widget.weeklyTaskListPageStyles.deviceWidth,
      height: widget.weeklyTaskListPageStyles.heightDp * 35,
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
              fontSize: widget.weeklyTaskListPageStyles.fontSp * 18,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Unrealised return",
            style: TextStyle(
              fontSize: widget.weeklyTaskListPageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _containerWeeklyTaskListTitle(BuildContext context) {
    return Container(
      width: widget.weeklyTaskListPageStyles.deviceWidth,
      height: widget.weeklyTaskListPageStyles.heightDp * 29,
      child: Column(
        children: [
          SizedBox(height: widget.weeklyTaskListPageStyles.heightDp * 5),
          Text(
            "Next update time: 12/10 00:00am",
            style: TextStyle(
              fontSize: widget.weeklyTaskListPageStyles.fontSp * 12,
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
        "title": "1st Week",
      },
      {
        "index": 1,
        "title": "2nd Week",
      },
      {
        "index": 2,
        "title": "3rd Week",
      },
      {
        "index": 3,
        "title": "4th Week",
      },
      {
        "index": 4,
        "title": "5th Week",
      },
    ];
    return Column(
      children: taskData.map((data) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.weeklyTaskListPageStyles.widthDp * 20,
                vertical: widget.weeklyTaskListPageStyles.heightDp * 14,
              ),
              height: widget.weeklyTaskListPageStyles.heightDp * 84,
              color: (_weekNumber != data["index"] + 1) ? Color(0xFF464646).withOpacity(0.2) : Color(0xFF10FFED).withOpacity(0.2),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["title"],
                          style: TextStyle(
                            fontSize: widget.weeklyTaskListPageStyles.fontSp * 26,
                            color: (_weekNumber != data["index"] + 1) ? Color(0xFFD3D3D3) : Colors.white,
                            fontFamily: "Avenir-Heavy",
                            height: 1,
                          ),
                        ),
                        Text(
                          (_weekNumber < data["index"] + 1) ? "Pending" : (_weekNumber == data["index"] + 1) ? "In Process" : "Finished",
                          style: TextStyle(
                            fontSize: widget.weeklyTaskListPageStyles.fontSp * 16,
                            color: (_weekNumber != data["index"] + 1) ? Color(0xFF9D9D9D) : Color(0xFF10FFED),
                            fontFamily: "Avenir-Medium",
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      KeicyRaisedButton(
                        width: widget.weeklyTaskListPageStyles.widthDp * 95,
                        height: widget.weeklyTaskListPageStyles.heightDp * 32,
                        color: (_weekNumber < data["index"] + 1)
                            ? Colors.transparent
                            : _weekNumber == data["index"] + 1 ? Color(0xFF10FFED).withOpacity(0.68) : Color(0xFF2785A5),
                        borderRadius: widget.weeklyTaskListPageStyles.heightDp * 16,
                        borderColor: (_weekNumber < data["index"] + 1)
                            ? Colors.white
                            : _weekNumber == data["index"] + 1 ? Colors.transparent : Color(0xFF2785A5),
                        child: Text(
                          (_weekNumber < data["index"] + 1) ? "Locked" : (_weekNumber == data["index"] + 1) ? "GO TO" : "Done",
                          style: TextStyle(
                            fontSize: widget.weeklyTaskListPageStyles.fontSp * 16,
                            color: _weekNumber > data["index"] + 1 ? Color(0xFF1BF7E7) : Colors.white,
                            fontFamily: "Avenir-Heavy",
                          ),
                        ),
                        elevation: 0,
                        onPressed: (_weekNumber != data["index"] + 1)
                            ? null
                            : () {
                                // if ((weekNumber < data["index"] + 1)) return;
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WeekChallengePage()));
                              },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: widget.weeklyTaskListPageStyles.widthDp * 5),
          ],
        );
      }).toList(),
    );
  }

  Widget _containerButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        KeicyRaisedButton(
          width: widget.weeklyTaskListPageStyles.widthDp * 148,
          height: widget.weeklyTaskListPageStyles.heightDp * 38,
          borderRadius: widget.weeklyTaskListPageStyles.heightDp * 19,
          color: Color(0xFF1979A2),
          elevation: 0,
          child: Text(
            "Back",
            style: TextStyle(
              fontSize: widget.weeklyTaskListPageStyles.fontSp * 17,
              color: Colors.white,
              fontFamily: "Avenir-Light",
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(height: widget.weeklyTaskListPageStyles.heightDp * 30),
      ],
    );
  }
}
