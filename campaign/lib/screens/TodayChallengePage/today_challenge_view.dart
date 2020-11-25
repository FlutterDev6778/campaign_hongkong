import 'dart:math';
import 'dart:ui';

import 'package:campaign/screens/QuestionnairePage/questionnaire_page.dart';
import 'package:campaign/screens/TempPage/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:provider/provider.dart';

import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';

import '../../providers/index.dart';

import '../App/index.dart';
import '../ArticlePage/index.dart';
import '../ChallengeListPanel/index.dart';
import '../IdiomPage/index.dart';
import '../RankingPage/index.dart';
import '../ReferralPage/index.dart';
import '../RulesPage/index.dart';
import '../WeekChallengePage/week_challenge_page.dart';
import '../WeeklyTaskListPage/index.dart';

import 'index.dart';

class TodayChallengeView extends StatefulWidget {
  final TodayChallengePageStyles todayChallengePageStyles;

  const TodayChallengeView({
    Key key,
    this.todayChallengePageStyles,
  }) : super(key: key);

  @override
  _TodayChallengeViewState createState() => _TodayChallengeViewState();
}

class _TodayChallengeViewState extends State<TodayChallengeView> {
  KeicyProgressDialog _keicyProgressDialog;
  CompletedTasksProvider _completedTasksProvider;
  Map<String, dynamic> _completedTaskData;
  List<dynamic> _completedList;
  String _weekDay;

  @override
  void initState() {
    super.initState();
    TodayTasksProvider.of(context).setTodayTasksState(TodayTasksState.init(), isNotifiable: false);
    CompletedTasksProvider.of(context).setCompletedTasksState(CompletedTasksState.init(), isNotifiable: false);
    _keicyProgressDialog = KeicyProgressDialog(context, message: "Please wait .....");
    _completedList = [];
    _completedTaskData = Map<String, dynamic>();
    _weekDay = "";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TodayTasksProvider.of(context).getTodayTasksData();
      CompletedTasksProvider.of(context).getCompletedTasksData();
    });
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
        }

        return SingleChildScrollView(
          child: Container(
            width: widget.todayChallengePageStyles.deviceWidth,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: widget.todayChallengePageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
                right: BorderSide(width: widget.todayChallengePageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
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
                    SizedBox(height: widget.todayChallengePageStyles.heightDp * 2),
                    _containerRealisedReturn(context),
                    _containerRatesPanel(context),
                    _containerTaskList(context),
                    SizedBox(height: widget.todayChallengePageStyles.heightDp * 6),
                    _containerWealther(context),
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
      top: widget.todayChallengePageStyles.statusbarHeight - widget.todayChallengePageStyles.heightDp * 40,
      child: Container(
        width: widget.todayChallengePageStyles.deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.rectangleForRulePage,
              height: widget.todayChallengePageStyles.heightDp * 160,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.todayChallengePageStyles.deviceWidth,
      height: widget.todayChallengePageStyles.heightDp * 125,
      padding: EdgeInsets.symmetric(horizontal: widget.todayChallengePageStyles.widthDp * 23),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: widget.todayChallengePageStyles.statusbarHeight),
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
                    child: Container(
                      width: widget.todayChallengePageStyles.heightDp * 35,
                      height: widget.todayChallengePageStyles.heightDp * 35,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.rankingIcon,
                          width: widget.todayChallengePageStyles.heightDp * 35,
                          height: widget.todayChallengePageStyles.heightDp * 35,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "TODAY\nchallenge".toUpperCase(),
                    style: TextStyle(
                      fontSize: widget.todayChallengePageStyles.fontSp * 29,
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
                      width: widget.todayChallengePageStyles.heightDp * 35,
                      height: widget.todayChallengePageStyles.heightDp * 35,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF269FC3)),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.helpIcon,
                          height: widget.todayChallengePageStyles.heightDp * 20,
                          fit: BoxFit.fitHeight,
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
    );
  }

  Widget _containerOsseyPanel(BuildContext context) {
    return Container(
      width: widget.todayChallengePageStyles.deviceWidth,
      height: widget.todayChallengePageStyles.heightDp * 53,
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
              fontSize: widget.todayChallengePageStyles.fontSp * 29,
              fontFamily: "Avenir-BlackOblique",
              height: 1.3,
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Ossey",
            style: TextStyle(
              fontSize: widget.todayChallengePageStyles.fontSp * 29,
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
      width: widget.todayChallengePageStyles.deviceWidth,
      height: widget.todayChallengePageStyles.heightDp * 35,
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
              fontSize: widget.todayChallengePageStyles.fontSp * 18,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFF10FFED),
            ),
          ),
          Text(
            " Unrealised return",
            style: TextStyle(
              fontSize: widget.todayChallengePageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _containerRatesPanel(BuildContext context) {
    return Container(
      width: widget.todayChallengePageStyles.deviceWidth,
      height: widget.todayChallengePageStyles.heightDp * 94,
      padding: EdgeInsets.symmetric(horizontal: widget.todayChallengePageStyles.widthDp * 15),
      child: Column(
        children: [
          SizedBox(height: widget.todayChallengePageStyles.heightDp * 3),
          Text(
            "Next update time: 12/10 00:00am",
            style: TextStyle(
              fontSize: widget.todayChallengePageStyles.fontSp * 12,
              fontFamily: "Avenir-BlackOblique",
              color: Color(0xFFB5B5B5),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: widget.todayChallengePageStyles.heightDp * 24,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Stack(
                          children: [
                            Transform.rotate(
                              angle: pi / 4,
                              child: Container(
                                width: _completedList.contains("t${index + 1}")
                                    ? widget.todayChallengePageStyles.heightDp * 24
                                    : widget.todayChallengePageStyles.heightDp * 16,
                                height: _completedList.contains("t${index + 1}")
                                    ? widget.todayChallengePageStyles.heightDp * 24
                                    : widget.todayChallengePageStyles.heightDp * 16,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3, color: Colors.white),
                                  color: Color(0xFF00638D),
                                  boxShadow: _completedList.contains("t${index + 1}")
                                      ? [
                                          BoxShadow(
                                            color: Color(0xFFF0FFF8).withOpacity(0.57),
                                            blurRadius: 6,
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                            ),
                            _completedList.contains("t${index + 1}")
                                ? SvgPicture.asset(
                                    AppAssets.gem1Icon,
                                    width: widget.todayChallengePageStyles.heightDp * 24,
                                    height: widget.todayChallengePageStyles.heightDp * 24,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(width: widget.todayChallengePageStyles.widthDp * 14),
                          Container(
                            width: widget.todayChallengePageStyles.heightDp * 5,
                            height: widget.todayChallengePageStyles.heightDp * 5,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          ),
                          SizedBox(width: widget.todayChallengePageStyles.widthDp * 14),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Image.asset(
                AppAssets.lockImg,
                width: widget.todayChallengePageStyles.heightDp * 70,
                height: widget.todayChallengePageStyles.heightDp * 70,
                fit: BoxFit.cover,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _containerTaskList(BuildContext context) {
    return Consumer<TodayTasksProvider>(builder: (context, todayTasksProvider, _) {
      String cohort = (_completedTaskData != null && _completedTaskData["cohort"] != null) ? _completedTaskData["cohort"].toString() : "c1";

      if (todayTasksProvider.todayTasksState.todayTaskData["success"] == null ||
          _completedTasksProvider.completedTasksState.completedTaskData["success"] == null) {
        return Container(
          height: widget.todayChallengePageStyles.heightDp * 129 * 3,
          child: Center(
            child: KeicyCupertinoIndicator(brightness: Brightness.dark),
          ),
        );
      }
      if (todayTasksProvider.todayTasksState.todayTaskData["success"] == false ||
          _completedTasksProvider.completedTasksState.completedTaskData["success"] == false) {
        return Container(
          height: widget.todayChallengePageStyles.heightDp * 129 * 3,
          padding: EdgeInsets.all(widget.todayChallengePageStyles.heightDp * 20),
          child: Center(
            child: Text(
              todayTasksProvider.todayTasksState.todayTaskData["data"] ?? "Today Challenge Data Error",
              style: TextStyle(
                fontSize: widget.todayChallengePageStyles.fontSp * 16,
                fontFamily: "Avenir-Heavy",
                color: Colors.white,
              ),
            ),
          ),
        );
      }
      List<Widget> taskListWidget = [];

      for (var i = 0; i < todayTasksProvider.todayTasksState.todayTaskData["data"]["tasks"].length; i++) {
        var data = todayTasksProvider.todayTasksState.todayTaskData["data"]["tasks"][i];
        taskListWidget.add(Column(
          children: [
            Container(
              width: widget.todayChallengePageStyles.deviceWidth,
              height: widget.todayChallengePageStyles.heightDp * 123,
              padding: EdgeInsets.symmetric(
                horizontal: widget.todayChallengePageStyles.widthDp * 23,
                vertical: widget.todayChallengePageStyles.heightDp * 12,
              ),
              color: _completedList.contains("t${i + 1}") ? Color(0xFF2E2E2E).withOpacity(0.2) : Color(0xFF10FFED).withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.todayChallengePageStyles.heightDp * 58,
                    height: widget.todayChallengePageStyles.heightDp * 38,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          AppAssets.gem1Icon,
                          width: widget.todayChallengePageStyles.heightDp * 33,
                          height: widget.todayChallengePageStyles.heightDp * 33,
                          fit: BoxFit.cover,
                        ),
                        // Positioned(
                        //   left: widget.todayChallengePageStyles.heightDp * 25,
                        //   bottom: 0,
                        //   child: Text(
                        //     "x${data["gemCount"] ?? ""}",
                        //     style: TextStyle(
                        //       fontSize: widget.todayChallengePageStyles.fontSp * 16,
                        //       fontFamily: "Avenir-Heavy",
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          right: widget.todayChallengePageStyles.heightDp * 35,
                          top: widget.todayChallengePageStyles.heightDp * 10,
                          child: Container(
                            width: widget.todayChallengePageStyles.heightDp * 2,
                            height: widget.todayChallengePageStyles.heightDp * 2,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              backgroundBlendMode: BlendMode.screen,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x77D3E6E6),
                                  blurRadius: 6,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: widget.todayChallengePageStyles.widthDp * 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["task_name"] ?? "",
                          style: TextStyle(
                            fontSize: widget.todayChallengePageStyles.fontSp * 16,
                            fontFamily: "Avenir-Heavy",
                            color: _completedList.contains("t${i + 1}") ? Color(0xFFC9C9C9) : Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data["task_desc"] ?? "",
                                style: TextStyle(
                                  fontSize: widget.todayChallengePageStyles.fontSp * 12,
                                  fontFamily: "Avenir-Heavy",
                                  color: _completedList.contains("t${i + 1}") ? Color(0xFFC9C9C9) : Colors.white,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: widget.todayChallengePageStyles.widthDp * 141,
                              height: widget.todayChallengePageStyles.heightDp * 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _completedList.contains("t${i + 1}") ? Colors.transparent : Color(0xFF10FFED),
                                ),
                                color: _completedList.contains("t${i + 1}") ? Color(0xFF414141) : Colors.transparent,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _completedList.contains("t${i + 1}") ? "1/1" : "0/1",
                                style: TextStyle(
                                  fontSize: widget.todayChallengePageStyles.fontSp * 12,
                                  color: Colors.white,
                                  fontFamily: "Avenir-Heavy",
                                  height: 1,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_completedList.contains("t${i + 1}")) return;
                                if (data["task_cat"] == "Article") {
                                  var result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => ArticlePage(
                                        cohort: cohort,
                                      ),
                                    ),
                                  );

                                  if (result != null) {
                                    KeicyProgressDialog keicyProgressDialog = KeicyProgressDialog(context, message: "Loading Task Complete api...");
                                    await keicyProgressDialog.show();
                                    await _completedTasksProvider.getCompletedTasksData();
                                    await keicyProgressDialog.hide();
                                  }
                                } else if (data["task_cat"] == "Questionnaire") {
                                  var result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => QuestionnairePage(cohort: cohort),
                                    ),
                                  );

                                  if (result != null) {
                                    KeicyProgressDialog keicyProgressDialog = KeicyProgressDialog(context, message: "Loading Task Complete api...");
                                    await keicyProgressDialog.show();
                                    await _completedTasksProvider.getCompletedTasksData();
                                    await keicyProgressDialog.hide();
                                  }
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => TempPage(
                                        title: data["task_id"] + " Page",
                                      ),
                                    ),
                                  );
                                }
                                // if (data["task_cat"] == "Article") {
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) => ArticlePage(articleID: "1"),
                                //     ),
                                //   );
                                // } else if (data["task_cat"] == "Questionnaire") {
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) => QuestionnairePage(questionnaireID: "1"),
                                //     ),
                                //   );
                                // }
                              },
                              child: Container(
                                width: widget.todayChallengePageStyles.widthDp * 74,
                                height: widget.todayChallengePageStyles.heightDp * 25,
                                decoration: BoxDecoration(
                                  color: _completedList.contains("t${i + 1}") ? Colors.transparent : Color(0xFF0BDAD7),
                                  border: Border.all(
                                    color: _completedList.contains("t${i + 1}") ? Color(0xFFC9C9C9).withOpacity(0.4) : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(widget.todayChallengePageStyles.widthDp * 13),
                                ),
                                child: Center(
                                  child: Text(
                                    _completedList.contains("t${i + 1}") ? "DONE" : "GO TO",
                                    style: TextStyle(
                                      fontSize: widget.todayChallengePageStyles.fontSp * 13,
                                      color: _completedList.contains("t${i + 1}") ? Color(0xFF10FFED) : Colors.white,
                                      fontFamily: "Avenir-Heavy",
                                    ),
                                  ),
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
            SizedBox(height: widget.todayChallengePageStyles.heightDp * 6),
          ],
        ));
      }

      return Column(
        children: taskListWidget,
      );
    });
  }

  Widget _containerWealther(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_completedList.length != 5) return;

        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IdiomPage()));
      },
      child: Container(
        width: widget.todayChallengePageStyles.deviceWidth,
        height: widget.todayChallengePageStyles.heightDp * 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _completedList.length == 5 ? null : Color(0xFF002C4E),
            gradient: _completedList.length == 5
                ? LinearGradient(
                    colors: [
                      Color(0xFF0D7E75).withOpacity(0.71),
                      Color(0xFF36D8CD).withOpacity(0.71),
                      Color(0xFF035A54).withOpacity(0.71),
                    ],
                    stops: [0, 0.5, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null),
        child: Text(
          "Wealthier !",
          style: TextStyle(
            fontSize: _completedList.length == 5 ? widget.todayChallengePageStyles.fontSp * 23 : widget.todayChallengePageStyles.fontSp * 15,
            fontFamily: "Avenir-Heavy",
            color: _completedList.length == 5 ? Colors.white : Color(0xFF8D8D8D),
          ),
        ),
      ),
    );
  }

  Widget _containerButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: widget.todayChallengePageStyles.heightDp * 80),
        KeicyRaisedButton(
          width: widget.todayChallengePageStyles.widthDp * 148,
          height: widget.todayChallengePageStyles.heightDp * 38,
          borderRadius: widget.todayChallengePageStyles.heightDp * 19,
          color: Color(0xFF1B5F7B),
          elevation: 0,
          child: Text(
            "Weekly Tasks",
            style: TextStyle(
              fontSize: widget.todayChallengePageStyles.fontSp * 16,
              color: Color(0xFF10FFED),
              fontFamily: "Avenir-Medium",
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WeeklyTaskListPage(weekDay: _weekDay)));
          },
        ),
        SizedBox(height: widget.todayChallengePageStyles.heightDp * 28),
        KeicyRaisedButton(
          width: widget.todayChallengePageStyles.widthDp * 148,
          height: widget.todayChallengePageStyles.heightDp * 38,
          borderRadius: widget.todayChallengePageStyles.heightDp * 19,
          color: Color(0xFF1B5974),
          borderColor: Colors.white,
          elevation: 0,
          child: Text(
            "Close",
            style: TextStyle(
              fontSize: widget.todayChallengePageStyles.fontSp * 17,
              color: Colors.white,
              fontFamily: "Avenir-Light",
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(height: widget.todayChallengePageStyles.heightDp * 45),
      ],
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
