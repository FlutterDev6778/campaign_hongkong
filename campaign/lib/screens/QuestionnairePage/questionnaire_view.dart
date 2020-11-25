import 'dart:math';
import 'dart:ui';

import 'package:campaign/DataProviders/Campaign/complete_questionnaire_task_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_rating_bar/keicy_rating_bar.dart';

import '../App/index.dart';
import '../../providers/index.dart';

import 'index.dart';

class QuestionnaireView extends StatefulWidget {
  final QuestionnairePageStyles questionnairePageStyles;
  final String cohort;

  const QuestionnaireView({
    Key key,
    this.questionnairePageStyles,
    this.cohort,
  }) : super(key: key);

  @override
  _QuestionnaireViewState createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  QuestionnaireProvider _questionnaireProvider;
  CompleteQuestionnaireTaskProvider _completeQuestionnaireTaskProvider;
  KeicyProgressDialog _keicyProgressDialog;
  double _review;

  @override
  void initState() {
    super.initState();

    _keicyProgressDialog = KeicyProgressDialog(context, message: "Please wait .....");
    _questionnaireProvider = QuestionnaireProvider.of(context);
    _completeQuestionnaireTaskProvider = CompleteQuestionnaireTaskProvider.of(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _questionnaireProvider.getQuestionnaireData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.questionnairePageStyles.deviceWidth,
        height: widget.questionnairePageStyles.deviceHeight,
        child: Stack(
          children: [
            Container(
              width: widget.questionnairePageStyles.deviceWidth,
              height: widget.questionnairePageStyles.deviceHeight,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: widget.questionnairePageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
                  right: BorderSide(width: widget.questionnairePageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF003B4D),
                    Color(0xFF00789B),
                    Color(0xFF007FA8),
                    Color(0xFF006A91),
                    Color(0xFF00638D),
                    Color(0xFF033F58),
                  ],
                  stops: [
                    0,
                    0.1,
                    0.2,
                    0.4,
                    0.6,
                    1,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: _containerMain(context),
            ),
            Consumer<CompleteQuestionnaireTaskProvider>(
              builder: (context, completeQuestionnaireTaskProvider, _) {
                if (completeQuestionnaireTaskProvider.completeQuestionnaireTaskState.progressState == 2) {
                  return _showSuccessDialog(context);
                }

                if (completeQuestionnaireTaskProvider.completeQuestionnaireTaskState.progressState == 1) {
                  return _showProgressing(context);
                }

                if (completeQuestionnaireTaskProvider.completeQuestionnaireTaskState.progressState == -1) {
                  return _showFailDialog(context, completeQuestionnaireTaskProvider);
                }

                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Container(
      width: widget.questionnairePageStyles.deviceWidth,
      height: widget.questionnairePageStyles.deviceHeight,
      child: Stack(
        children: [
          _containerRectangles(context),
          Column(
            children: [
              SizedBox(height: widget.questionnairePageStyles.statusbarHeight),
              _containerHeader(context),
              Expanded(
                child: Consumer<QuestionnaireProvider>(builder: (context, questionnaireProvider, _) {
                  if (questionnaireProvider.questionnaireState.questionnaireData["success"] == null) {
                    return Center(
                      child: KeicyCupertinoIndicator(brightness: Brightness.dark),
                    );
                  }
                  if (!questionnaireProvider.questionnaireState.questionnaireData["success"]) {
                    return Center(
                      child: Text(
                        questionnaireProvider.questionnaireState.questionnaireData["data"] ??
                            questionnaireProvider.questionnaireState.questionnaireData["msg"] ??
                            "Getting Questionnaire Data Error",
                        style: TextStyle(
                          fontSize: widget.questionnairePageStyles.fontSp * 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  return _mainPanel(context, questionnaireProvider);
                }),
              ),
              KeicyRaisedButton(
                width: widget.questionnairePageStyles.widthDp * 172,
                height: widget.questionnairePageStyles.heightDp * 45,
                borderRadius: widget.questionnairePageStyles.heightDp * 23,
                color: Color(0xFF1B617E),
                elevation: 0,
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontFamily: "Avenir-Light",
                    fontSize: widget.questionnairePageStyles.fontSp * 21,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: widget.questionnairePageStyles.heightDp * 25),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      left: -widget.questionnairePageStyles.heightDp * 5,
      top: widget.questionnairePageStyles.statusbarHeight - widget.questionnairePageStyles.heightDp * 40,
      child: Container(
        width: widget.questionnairePageStyles.deviceWidth,
        child: Image.asset(
          AppAssets.rectangleForRulePage,
          height: widget.questionnairePageStyles.heightDp * 160,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.questionnairePageStyles.deviceWidth,
      child: Container(
        width: widget.questionnairePageStyles.deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: widget.questionnairePageStyles.widthDp * 23),
        child: Column(
          children: [
            SizedBox(height: widget.questionnairePageStyles.heightDp * 20),
            Text(
              "Questionnaire".toUpperCase(),
              style: TextStyle(
                fontSize: widget.questionnairePageStyles.fontSp * 25,
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

  Widget _mainPanel(BuildContext context, QuestionnaireProvider questionnaireProvider) {
    return Container(
      width: widget.questionnairePageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: widget.questionnairePageStyles.widthDp * 30),
      child: Column(
        children: [
          SizedBox(height: widget.questionnairePageStyles.heightDp * 70),
          Text(
            questionnaireProvider.questionnaireState.questionnaireData["data"]["questionnaire"]["EN"],
            style: TextStyle(
              fontFamily: "Avenir-Heavy",
              fontSize: widget.questionnairePageStyles.fontSp * 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: widget.questionnairePageStyles.heightDp * 20),
          Row(
            children: [
              SizedBox(width: widget.questionnairePageStyles.widthDp * 20),
              KeicyRatingBar(
                size: widget.questionnairePageStyles.heightDp * 25,
                spacing: widget.questionnairePageStyles.widthDp * 15,
                allowHalfRating: false,
                defaultIconData: Icon(
                  Icons.star,
                  size: widget.questionnairePageStyles.heightDp * 25,
                  color: Colors.white,
                ),
                filledIconData: Icon(
                  Icons.star,
                  size: widget.questionnairePageStyles.heightDp * 25,
                  color: Color(0xFF10FFED),
                ),
                halfStarThreshold: 0.5,
                onRated: (value) {
                  setState(() {
                    _review = value;
                  });
                },
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          KeicyRaisedButton(
            width: widget.questionnairePageStyles.widthDp * 172,
            height: widget.questionnairePageStyles.heightDp * 45,
            borderRadius: widget.questionnairePageStyles.heightDp * 23,
            color: _review != null ? Color(0xFF169DAD) : Color(0xFF1B617E),
            elevation: 0,
            child: Text(
              "Confirm",
              style: TextStyle(
                fontFamily: "Avenir-Light",
                fontSize: widget.questionnairePageStyles.fontSp * 21,
                color: Colors.white,
              ),
            ),
            onPressed: _review == null
                ? null
                : () async {
                    _completeQuestionnaireTaskProvider.setCompleteQuestionnaireTaskState(
                      _completeQuestionnaireTaskProvider.completeQuestionnaireTaskState.update(
                        progressState: 1,
                      ),
                    );
                    _completeQuestionnaireTaskProvider.getCompleteQuestionnaireTaskData(widget.cohort, _review);
                  },
          ),
          SizedBox(height: widget.questionnairePageStyles.heightDp * 32),
        ],
      ),
    );
  }

  Widget _showSuccessDialog(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(true);
    });
    return Container(
      width: widget.questionnairePageStyles.deviceWidth,
      height: widget.questionnairePageStyles.deviceHeight,
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: widget.questionnairePageStyles.heightDp * 50,
            color: Colors.white,
          ),
          Text(
            "Completed!\nThank you.",
            style: TextStyle(
              fontFamily: "Avenir-HeavyOblique",
              fontSize: widget.questionnairePageStyles.fontSp * 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _showProgressing(BuildContext context) {
    return Container(
      width: widget.questionnairePageStyles.deviceWidth,
      height: widget.questionnairePageStyles.deviceHeight,
      color: Colors.black.withOpacity(0.7),
      alignment: Alignment.center,
      child: Center(
        child: KeicyCupertinoIndicator(
          brightness: Brightness.dark,
        ),
      ),
    );
  }

  Widget _showFailDialog(BuildContext context, CompleteQuestionnaireTaskProvider completeQuestionnaireTaskProvider) {
    Future.delayed(Duration(seconds: 2), () {
      completeQuestionnaireTaskProvider.setCompleteQuestionnaireTaskState(
        completeQuestionnaireTaskProvider.completeQuestionnaireTaskState.update(
          progressState: 0,
          errorString: "",
        ),
      );
    });

    return Container(
      width: widget.questionnairePageStyles.deviceWidth,
      height: widget.questionnairePageStyles.deviceHeight,
      color: Colors.black.withOpacity(0.7),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: widget.questionnairePageStyles.heightDp * 50,
            color: Colors.white,
          ),
          Text(
            completeQuestionnaireTaskProvider.completeQuestionnaireTaskState.completeQuestionnaireTaskData["data"],
            style: TextStyle(
              fontFamily: "Avenir-HeavyOblique",
              fontSize: widget.questionnairePageStyles.fontSp * 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
