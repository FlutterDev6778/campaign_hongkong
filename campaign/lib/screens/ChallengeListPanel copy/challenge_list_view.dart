import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/RegisterChallengePanel/register_challenge_panel.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:campaign/screens/TodayChallengePage/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:keicy_raised_button/keicy_raised_button.dart';

import '../App/index.dart';

import 'index.dart';

class ChallengeListView extends StatefulWidget {
  final ChallengeListPanelStyles challengeListPanelStyles;
  final Map<String, dynamic> campaignData;

  const ChallengeListView({
    Key key,
    this.challengeListPanelStyles,
    this.campaignData,
  }) : super(key: key);

  @override
  _ChallengeListViewState createState() => _ChallengeListViewState();
}

class _ChallengeListViewState extends State<ChallengeListView> {
  RegisterChallengeProvider _registerChallengeProvider;

  bool isTimeUp = true;
  double mainHeight;

  @override
  void initState() {
    super.initState();

    _registerChallengeProvider = RegisterChallengeProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = widget.challengeListPanelStyles.heightDp * (35 + 5 + 26 + 35) + widget.challengeListPanelStyles.windowHeight;

    return Consumer<RegisterChallengeProvider>(builder: (context, registerChallengeProvider, _) {
      _registerChallengeProvider = registerChallengeProvider;
      return Container(
        width: widget.challengeListPanelStyles.deviceWidth,
        height: widget.challengeListPanelStyles.deviceHeight,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: widget.challengeListPanelStyles.deviceWidth,
            height: mainHeight,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _containerHelperButton(context),
                    SizedBox(height: widget.challengeListPanelStyles.heightDp * 5),
                    Stack(
                      children: [
                        _contaienrBackground(context),
                        (_registerChallengeProvider.registerChallengeState.step == 0)
                            ? _containerStartChallengePanel(context)
                            : _containerRegisterChallengePanel(context),
                      ],
                    ),
                    SizedBox(height: widget.challengeListPanelStyles.heightDp * 26),
                    _containerCloseButton(context),
                  ],
                ),
                // (_registerChallengeProvider.registerChallengeState.step == 0) ? SizedBox() : _containerCategory(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _contaienrBackground(BuildContext context) {
    return Container(
      width: widget.challengeListPanelStyles.deviceWidth,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: widget.challengeListPanelStyles.windowWidth,
            child: SvgPicture.asset(
              widget.campaignData["campaign_id"] == 10002 ? AppAssets.popupWinBackImage2 : AppAssets.popupWinBackImage1,
              width: widget.challengeListPanelStyles.windowWidth,
              height: widget.challengeListPanelStyles.windowHeight,
              fit: BoxFit.fill,
            ),
          ),
          (_registerChallengeProvider.registerChallengeState.step == 0)
              ? Container(
                  width: widget.challengeListPanelStyles.windowWidth,
                  height: widget.challengeListPanelStyles.windowHeight,
                  alignment: Alignment.center,
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.lineBackImage,
                      width: widget.challengeListPanelStyles.windowWidth,
                      height: widget.challengeListPanelStyles.windowHeight - widget.challengeListPanelStyles.heightDp * 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Positioned(
                  right: widget.challengeListPanelStyles.widthDp * 30,
                  bottom: widget.challengeListPanelStyles.heightDp * 25,
                  child: ClipRect(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppAssets.lineBack1Image,
                          width: widget.challengeListPanelStyles.widthDp * 106,
                          height: widget.challengeListPanelStyles.heightDp * 245,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _containerHelperButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: (widget.challengeListPanelStyles.deviceWidth - widget.challengeListPanelStyles.windowWidth) / 2 +
            widget.challengeListPanelStyles.widthDp * 10,
      ),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RulesPage()));
        },
        child: Container(
          width: widget.challengeListPanelStyles.heightDp * 35,
          height: widget.challengeListPanelStyles.heightDp * 35,
          decoration: BoxDecoration(
            color: Color(0xFF384646),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppAssets.helpIcon,
            height: widget.challengeListPanelStyles.heightDp * 17,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _containerStartChallengePanel(BuildContext context) {
    return Container(
      width: widget.challengeListPanelStyles.deviceWidth,
      height: widget.challengeListPanelStyles.windowHeight,
      padding: EdgeInsets.only(
        left: (widget.challengeListPanelStyles.deviceWidth - widget.challengeListPanelStyles.windowWidth) / 2,
        right:
            (widget.challengeListPanelStyles.deviceWidth - widget.challengeListPanelStyles.windowWidth) / 2 + widget.challengeListPanelStyles.widthDp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 45),
          Text(
            "Challenge\nlist".toUpperCase(),
            style: widget.challengeListPanelStyles.titleStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 40),

          /// ChallengeDay center widget
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: widget.challengeListPanelStyles.heightDp * 123,
                  height: widget.challengeListPanelStyles.heightDp * 123,
                  child: Stack(
                    children: [
                      Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          width: widget.challengeListPanelStyles.heightDp * 123,
                          height: widget.challengeListPanelStyles.heightDp * 123,
                          decoration: widget.campaignData["campaign_id"] == 10002
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.widthDp * 8),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFA5043F),
                                      Color(0xFF8D042E),
                                      Color(0xFF000029),
                                      Color(0xFF000029),
                                    ],
                                    stops: [0, 0.15, 0.55, 1],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFF0FFFD).withOpacity(0.41),
                                      offset: Offset(2, 0),
                                      blurRadius: 10,
                                    )
                                  ],
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.widthDp * 8),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF04768D),
                                      Color(0xFF04768D),
                                      Color(0xFF000029),
                                      Color(0xFF000029),
                                    ],
                                    stops: [0, 0.15, 0.6, 1],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFF0FFFD).withOpacity(0.41),
                                      offset: Offset(2, 0),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                          alignment: Alignment.center,
                          child: Container(
                            width: widget.challengeListPanelStyles.heightDp * 107,
                            height: widget.challengeListPanelStyles.heightDp * 107,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: widget.challengeListPanelStyles.widthDp * 2,
                                color: Color(0xFFD6D6D6),
                              ),
                              borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.heightDp * 6),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: widget.challengeListPanelStyles.heightDp * 123,
                        height: widget.challengeListPanelStyles.heightDp * 123,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.campaignData["campaign_name"].toString().toUpperCase(),
                              style: widget.challengeListPanelStyles.challengeDayStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: widget.challengeListPanelStyles.heightDp * 15),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// start button
          KeicyRaisedButton(
            width: widget.challengeListPanelStyles.widthDp * 132,
            height: widget.challengeListPanelStyles.heightDp * 35,
            color: Colors.white.withOpacity(0.68),
            borderRadius: widget.challengeListPanelStyles.heightDp * 18,
            child: Text(
              "Start",
              style: widget.challengeListPanelStyles.startButtonTextStyle,
            ),
            onPressed: () {
              if (widget.campaignData["campaign_id"] != 10002) {
                _registerChallengeProvider.setRegisterChallengeState(
                  _registerChallengeProvider.registerChallengeState.update(step: 1),
                );
              }
            },
          ),
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 85),
        ],
      ),
    );
  }

  Widget _containerRegisterChallengePanel(BuildContext context) {
    return Container(
      width: widget.challengeListPanelStyles.deviceWidth,
      height: widget.challengeListPanelStyles.windowHeight,
      // padding: EdgeInsets.only(
      //   left: (widget.challengeListPanelStyles.deviceWidth - widget.challengeListPanelStyles.windowWidth) / 2,
      //   right:
      //       (widget.challengeListPanelStyles.deviceWidth - widget.challengeListPanelStyles.windowWidth) / 2 + widget.challengeListPanelStyles.widthDp,
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 18),
          Container(
            width: widget.challengeListPanelStyles.deviceWidth,
            height: widget.challengeListPanelStyles.heightDp * 100,
            alignment: Alignment.center,
            child: Text(
              "Challenge\nlist".toUpperCase(),
              style: widget.challengeListPanelStyles.titleStyle,
              textAlign: TextAlign.center,
            ),
          ),

          /// campign
          Container(
            width: widget.challengeListPanelStyles.deviceWidth,
            alignment: Alignment.center,
            child: Container(
              width: widget.challengeListPanelStyles.widthDp * 279,
              decoration: BoxDecoration(
                color: Color(0xFF062F3F),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE8FF3B).withOpacity(0.45),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: widget.challengeListPanelStyles.heightDp * 88,
                    padding: EdgeInsets.only(left: widget.challengeListPanelStyles.heightDp * 85 + widget.challengeListPanelStyles.widthDp * 10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.campaignData["campaign_name"]
                              .toString()
                              .substring(widget.campaignData["campaign_name"].toString().split(" ")[0].length)
                              .trim()
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: widget.challengeListPanelStyles.fontSp * 18,
                            color: AppColors.whiteColor,
                            fontFamily: "Avenir-Heavy",
                          ),
                        ),
                        SizedBox(height: widget.challengeListPanelStyles.heightDp * 5),
                        Text(
                          "   " + widget.campaignData["campaign_description"].toUpperCase(),
                          style: TextStyle(
                            fontSize: widget.challengeListPanelStyles.fontSp * 11,
                            color: Color(0xFF10FFED),
                            fontFamily: "Avenir-HeavyOblique",
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_registerChallengeProvider.registerChallengeState.step == 1) {
                        Navigator.of(context).pop();
                        RegisterChallengePanel().show(context, widget.campaignData);
                      } else if (_registerChallengeProvider.registerChallengeState.step == 2) {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TodayChallengePage()));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: widget.challengeListPanelStyles.heightDp * 37,
                      decoration: BoxDecoration(color: Color(0xFF004398)),
                      child: Center(
                        child: Text(
                          _registerChallengeProvider.registerChallengeState.step == 1 ? "Register NOW" : "Start NOW >>",
                          style: TextStyle(
                            fontSize: widget.challengeListPanelStyles.fontSp * 13,
                            color: _registerChallengeProvider.registerChallengeState.step == 1 ? Color(0xFF10FFED) : Color(0xFFFFDA10),
                            fontFamily: "Avenir-HeavyOblique",
                          ),
                        ),
                      ),
                    ),
                  ),
                  isTimeUp
                      ? SizedBox(height: widget.challengeListPanelStyles.heightDp * 13)
                      : Stack(
                          children: [
                            Opacity(
                              opacity: 0.87,
                              child: Container(
                                width: double.infinity,
                                height: widget.challengeListPanelStyles.heightDp * 34,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF747474).withOpacity(0),
                                      Color(0xFF272901),
                                    ],
                                    stops: [0, 1],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: widget.challengeListPanelStyles.heightDp * 34,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: widget.challengeListPanelStyles.widthDp * 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "6 Days : 7hrs : 20 mins ",
                                    style: TextStyle(
                                      fontSize: widget.challengeListPanelStyles.fontSp * 13,
                                      color: Color(0xFFFFE310),
                                      fontFamily: "Avenir-HeavyOblique",
                                    ),
                                  ),
                                  Text(
                                    "Until Next Round",
                                    style: TextStyle(
                                      fontSize: widget.challengeListPanelStyles.fontSp * 10,
                                      color: Color(0xFFA8A8A8),
                                      fontFamily: "Avenir-HeavyOblique",
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
          ),

          ///
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 27),

          /// sub-campign
          (widget.campaignData["sub_campaigns"] != null &&
                  widget.campaignData["sub_campaigns"] != "" &&
                  widget.campaignData["sub_campaigns"].length != 0)
              ? Container(
                  width: widget.challengeListPanelStyles.deviceWidth,
                  alignment: Alignment.center,
                  child: Container(
                    width: widget.challengeListPanelStyles.widthDp * 279,
                    decoration: BoxDecoration(
                      color: Color(0xFF01594A),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE8FF3B).withOpacity(0.45),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: widget.challengeListPanelStyles.heightDp * 60,
                          padding:
                              EdgeInsets.only(left: widget.challengeListPanelStyles.heightDp * 60 + widget.challengeListPanelStyles.widthDp * 10),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.campaignData["sub_campaigns"][0]["sub_campaign_name"]
                                    .toString()
                                    .substring(widget.campaignData["sub_campaigns"][0]["sub_campaign_name"].toString().split(" ")[0].length)
                                    .trim()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: widget.challengeListPanelStyles.fontSp * 15,
                                  color: AppColors.whiteColor,
                                  fontFamily: "Avenir-Heavy",
                                ),
                              ),
                              SizedBox(height: widget.challengeListPanelStyles.heightDp * 5),
                              Text(
                                "   " + widget.campaignData["sub_campaigns"][0]["sub_campaign_description"].toUpperCase(),
                                style: TextStyle(
                                  fontSize: widget.challengeListPanelStyles.fontSp * 10,
                                  color: Color(0xFF10FF7E),
                                  fontFamily: "Avenir-HeavyOblique",
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_registerChallengeProvider.registerChallengeState.step == 1) {
                              Navigator.of(context).pop();
                              RegisterChallengePanel().show(context, widget.campaignData);
                            } else if (_registerChallengeProvider.registerChallengeState.step == 2) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TodayChallengePage()));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: widget.challengeListPanelStyles.heightDp * 37,
                            decoration: BoxDecoration(color: Color(0xFF004398)),
                            child: Center(
                              child: Text(
                                _registerChallengeProvider.registerChallengeState.step == 1 ? "Register NOW" : "Start NOW >>",
                                style: TextStyle(
                                  fontSize: widget.challengeListPanelStyles.fontSp * 13,
                                  color: _registerChallengeProvider.registerChallengeState.step == 1 ? Color(0xFF10FFED) : Color(0xFFFFDA10),
                                  fontFamily: "Avenir-HeavyOblique",
                                ),
                              ),
                            ),
                          ),
                        ),
                        isTimeUp
                            ? SizedBox(height: widget.challengeListPanelStyles.heightDp * 13)
                            : Stack(
                                children: [
                                  Opacity(
                                    opacity: 0.87,
                                    child: Container(
                                      width: double.infinity,
                                      height: widget.challengeListPanelStyles.heightDp * 34,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF747474).withOpacity(0),
                                            Color(0xFF272901),
                                          ],
                                          stops: [0, 1],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: widget.challengeListPanelStyles.heightDp * 34,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: widget.challengeListPanelStyles.widthDp * 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "6 Days : 7hrs : 20 mins ",
                                          style: TextStyle(
                                            fontSize: widget.challengeListPanelStyles.fontSp * 13,
                                            color: Color(0xFFFFE310),
                                            fontFamily: "Avenir-HeavyOblique",
                                          ),
                                        ),
                                        Text(
                                          "Until Next Round",
                                          style: TextStyle(
                                            fontSize: widget.challengeListPanelStyles.fontSp * 10,
                                            color: Color(0xFFA8A8A8),
                                            fontFamily: "Avenir-HeavyOblique",
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
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _containerCategory(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: widget.challengeListPanelStyles.widthDp * 38,
        top: (widget.challengeListPanelStyles.heightDp * 812 - mainHeight) / 2,
      ),
      child: Column(
        children: [
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 105),
          Transform.rotate(
            angle: pi / 4,
            child: Container(
              width: widget.challengeListPanelStyles.heightDp * 84.5,
              height: widget.challengeListPanelStyles.heightDp * 84.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.heightDp * 8),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF04768D).withOpacity(0.86),
                    Color(0xFF04768D).withOpacity(0.86),
                    Color(0xFF000029).withOpacity(0.86),
                    Color(0xFF000029).withOpacity(0.86),
                  ],
                  stops: [0, 0.15, 0.6, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF0FFFD).withOpacity(0.41),
                    offset: Offset(2, 0),
                    blurRadius: 10,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Container(
                width: widget.challengeListPanelStyles.heightDp * 72,
                height: widget.challengeListPanelStyles.heightDp * 72,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: widget.challengeListPanelStyles.heightDp * 2,
                    color: Color(0xFFD6D6D6),
                  ),
                  borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.heightDp * 6),
                ),
                child: Transform.rotate(
                  angle: -pi / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.campaignData["campaign_name"].toString().split(' ')[0],
                        style: TextStyle(
                          fontSize: widget.challengeListPanelStyles.fontSp * 40,
                          color: AppColors.whiteColor,
                          fontFamily: "Avenir-HeavyOblique",
                          shadows: [
                            BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.65),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: widget.challengeListPanelStyles.heightDp * 15),
          (widget.campaignData["sub_campaigns"] != null &&
                  widget.campaignData["sub_campaigns"] != "" &&
                  widget.campaignData["sub_campaigns"].length != 0)
              ? DottedLine(
                  direction: Axis.vertical,
                  lineLength: widget.challengeListPanelStyles.heightDp * 97 - (isTimeUp ? widget.challengeListPanelStyles.heightDp * 21 : 0),
                  lineThickness: 3.0,
                  dashLength: 4.0,
                  dashColor: Colors.white,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                )
              : SizedBox(),
          (widget.campaignData["sub_campaigns"] != null &&
                  widget.campaignData["sub_campaigns"] != "" &&
                  widget.campaignData["sub_campaigns"].length != 0)
              ? Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    width: widget.challengeListPanelStyles.heightDp * 45,
                    height: widget.challengeListPanelStyles.heightDp * 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.heightDp * 8),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF7CBE3F).withOpacity(0.86),
                          Color(0xFF04768D).withOpacity(0.86),
                          Color(0xFF000029).withOpacity(0.86),
                          Color(0xFF000029).withOpacity(0.86),
                        ],
                        stops: [0, 0.34, 0.66, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF0FFFD).withOpacity(0.41),
                          offset: Offset(2, 0),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: widget.challengeListPanelStyles.heightDp * 38.4,
                      height: widget.challengeListPanelStyles.heightDp * 38.4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: widget.challengeListPanelStyles.heightDp * 2,
                          color: Color(0xFFD6D6D6),
                        ),
                        borderRadius: BorderRadius.circular(widget.challengeListPanelStyles.heightDp * 5),
                      ),
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.campaignData["sub_campaigns"][0]["sub_campaign_name"].toString().split(' ')[0],
                              style: TextStyle(
                                fontSize: widget.challengeListPanelStyles.fontSp * 24,
                                color: AppColors.whiteColor,
                                fontFamily: "Avenir-HeavyOblique",
                                shadows: [
                                  BoxShadow(
                                    color: Color(0xFF000000).withOpacity(0.65),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _containerCloseButton(BuildContext context) {
    return KeicyRaisedButton(
      width: widget.challengeListPanelStyles.widthDp * 132,
      height: widget.challengeListPanelStyles.heightDp * 35,
      color: Colors.white.withOpacity(0.1),
      borderColor: AppColors.whiteColor,
      borderRadius: widget.challengeListPanelStyles.widthDp * 18,
      child: Text("Close", style: widget.challengeListPanelStyles.closeButtonTextStyle),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
