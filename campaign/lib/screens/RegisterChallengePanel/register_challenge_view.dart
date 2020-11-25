import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/LinkBankAccountPage/index.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:keicy_raised_button/keicy_raised_button.dart';

import '../App/index.dart';

import 'index.dart';

class RegisterChallengeView extends StatefulWidget {
  final RegisterChallengePanelStyles registerChallengePanelStyles;
  final Map<String, dynamic> campaignData;

  const RegisterChallengeView({
    Key key,
    this.registerChallengePanelStyles,
    this.campaignData,
  }) : super(key: key);

  @override
  _RegisterChallengeViewState createState() => _RegisterChallengeViewState();
}

class _RegisterChallengeViewState extends State<RegisterChallengeView> {
  int step; // 0: confirm register, 1: confirming, 2: registered

  @override
  void initState() {
    super.initState();

    step = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.registerChallengePanelStyles.windowHeight = widget.registerChallengePanelStyles.deviceHeight -
        widget.registerChallengePanelStyles.statusbarHeight -
        widget.registerChallengePanelStyles.heightDp * (5 + 35 + 5 + 20 + 35 + 40);

    return Consumer<RegisterChallengeProvider>(builder: (context, registerChallengeProvider, _) {
      return Container(
        width: widget.registerChallengePanelStyles.deviceWidth,
        height: widget.registerChallengePanelStyles.deviceHeight,
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: widget.registerChallengePanelStyles.statusbarHeight),
            SizedBox(height: widget.registerChallengePanelStyles.heightDp * 5),
            _containerHelperButton(context),
            SizedBox(height: widget.registerChallengePanelStyles.heightDp * 5),
            Container(
              width: widget.registerChallengePanelStyles.deviceWidth,
              height: widget.registerChallengePanelStyles.windowHeight,
              child: Stack(
                children: [
                  _contaienrBackground(context),
                  registerChallengeProvider.registerChallengeState.progressState == 0
                      ? _containerConfirmPanel(context)
                      : registerChallengeProvider.registerChallengeState.progressState == 1
                          ? _containerRegisteringPanel(context)
                          : (registerChallengeProvider.registerChallengeState.progressState == 2) ? _containerRegisteredPanel(context) : SizedBox(),
                ],
              ),
            ),
            SizedBox(height: widget.registerChallengePanelStyles.heightDp * 20),
            _containerCloseButton(context),
            SizedBox(height: widget.registerChallengePanelStyles.heightDp * 40),
          ],
        ),
      );
      return Container(
        width: widget.registerChallengePanelStyles.windowWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _containerHelperButton(context),
                SizedBox(width: widget.registerChallengePanelStyles.widthDp * 10),
              ],
            ),
            SizedBox(height: widget.registerChallengePanelStyles.heightDp * 10),
            Stack(
              children: [
                _contaienrBackground(context),
                registerChallengeProvider.registerChallengeState.progressState == 0
                    ? _containerConfirmPanel(context)
                    : registerChallengeProvider.registerChallengeState.progressState == 1
                        ? _containerRegisteringPanel(context)
                        : (registerChallengeProvider.registerChallengeState.progressState == 2) ? _containerRegisteredPanel(context) : SizedBox(),
              ],
            ),
            SizedBox(height: widget.registerChallengePanelStyles.heightDp * 20),
            _containerCloseButton(context),
          ],
        ),
      );
    });
  }

  Widget _contaienrBackground(BuildContext context) {
    return Container(
      width: widget.registerChallengePanelStyles.deviceWidth,
      height: widget.registerChallengePanelStyles.windowHeight,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.registerChallengePanelStyles.heightDp * 20),
        child: Stack(
          children: [
            Container(
              width: widget.registerChallengePanelStyles.windowWidth,
              height: widget.registerChallengePanelStyles.windowHeight,
              child: Column(
                children: [
                  Container(
                    height: widget.registerChallengePanelStyles.heightDp * 115,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF003D4F),
                          Color(0xFF0782A2),
                        ],
                        stops: [0, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Container(
                    height: widget.registerChallengePanelStyles.heightDp * 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF063848),
                          Color(0xFF063242),
                        ],
                        stops: [0, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Container(
                    height: widget.registerChallengePanelStyles.heightDp * 40,
                    decoration: BoxDecoration(color: Color(0xFF051412)),
                  ),
                  Container(
                    height: widget.registerChallengePanelStyles.heightDp * 60,
                    decoration: BoxDecoration(color: Color(0xFF05392E)),
                  ),
                  Container(
                    height: widget.registerChallengePanelStyles.heightDp * 40,
                    decoration: BoxDecoration(color: Color(0xFF021B2D)),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF003F5E),
                            Color(0xFF06273A),
                          ],
                          stops: [0, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: widget.registerChallengePanelStyles.windowWidth,
              height: widget.registerChallengePanelStyles.windowHeight,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              width: widget.registerChallengePanelStyles.windowWidth,
              height: widget.registerChallengePanelStyles.windowHeight,
              child: Container(color: Colors.black.withOpacity(0.47)),
            ),
            Container(
              width: widget.registerChallengePanelStyles.windowWidth,
              height: widget.registerChallengePanelStyles.windowHeight,
              child: Container(color: Color(0xFF8B9195).withOpacity(0.6)),
            ),
            Container(
              width: widget.registerChallengePanelStyles.windowWidth,
              height: widget.registerChallengePanelStyles.heightDp * 152,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3C8B7F).withOpacity(0.6),
                    Color(0xFF1A7C6D).withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerHelperButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: (widget.registerChallengePanelStyles.deviceWidth - widget.registerChallengePanelStyles.windowWidth) / 2 +
            widget.registerChallengePanelStyles.widthDp * 10,
      ),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RulesPage()));
        },
        child: Container(
          width: widget.registerChallengePanelStyles.heightDp * 35,
          height: widget.registerChallengePanelStyles.heightDp * 35,
          decoration: BoxDecoration(
            color: Color(0xFF384646),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppAssets.helpIcon,
            height: widget.registerChallengePanelStyles.heightDp * 17,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _containerConfirmPanel(BuildContext context) {
    return Container(
      width: widget.registerChallengePanelStyles.deviceWidth,
      height: widget.registerChallengePanelStyles.windowHeight,
      alignment: Alignment.center,
      child: Container(
        width: widget.registerChallengePanelStyles.windowWidth,
        height: widget.registerChallengePanelStyles.windowHeight,
        padding: EdgeInsets.symmetric(
          horizontal: widget.registerChallengePanelStyles.widthDp * 45,
          vertical: widget.registerChallengePanelStyles.heightDp * 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: widget.registerChallengePanelStyles.heightDp * 58,
                  height: widget.registerChallengePanelStyles.heightDp * 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppAssets.helpIcon,
                    width: widget.registerChallengePanelStyles.heightDp * 30,
                    height: widget.registerChallengePanelStyles.heightDp * 30,
                    color: Color(0xFF5F5F5F),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: widget.registerChallengePanelStyles.heightDp * 10),
                Text(
                  "Confirmation",
                  style: TextStyle(
                    fontSize: widget.registerChallengePanelStyles.fontSp * 20,
                    color: Colors.white,
                    fontFamily: "Avenir-Heavy",
                  ),
                ),
              ],
            ),
            Text(
              "Are you sure to register the challenge now?",
              style: TextStyle(
                fontSize: widget.registerChallengePanelStyles.fontSp * 20,
                color: Colors.white,
                fontFamily: "Avenir-HeavyOblique",
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                KeicyRaisedButton(
                  width: widget.registerChallengePanelStyles.widthDp * 168,
                  height: widget.registerChallengePanelStyles.heightDp * 42,
                  borderRadius: widget.registerChallengePanelStyles.heightDp * 21,
                  color: Color(0xFF00BCB6),
                  elevation: 0,
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: widget.registerChallengePanelStyles.fontSp * 17,
                      color: Colors.white,
                      fontFamily: "Avenir_Black",
                    ),
                  ),
                  onPressed: () {
                    RegisterChallengeProvider.of(context).setRegisterChallengeState(
                      RegisterChallengeProvider.of(context).registerChallengeState.update(
                            progressState: 1,
                          ),
                    );
                    RegisterChallengeProvider.of(context).registerChallenge();
                  },
                ),
                SizedBox(height: widget.registerChallengePanelStyles.heightDp * 28),
                KeicyRaisedButton(
                  width: widget.registerChallengePanelStyles.widthDp * 168,
                  height: widget.registerChallengePanelStyles.heightDp * 42,
                  borderRadius: widget.registerChallengePanelStyles.heightDp * 21,
                  color: Color(0xFF7C96A1),
                  elevation: 0,
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: widget.registerChallengePanelStyles.fontSp * 18,
                      color: Colors.white,
                      fontFamily: "Avenir-Book",
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ChallengeListPanel().show(context, widget.campaignData);
                  },
                ),
                SizedBox(height: widget.registerChallengePanelStyles.heightDp * 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerRegisteringPanel(BuildContext context) {
    return Container(
      width: widget.registerChallengePanelStyles.deviceWidth,
      height: widget.registerChallengePanelStyles.windowHeight,
      alignment: Alignment.center,
      child: Container(
        width: widget.registerChallengePanelStyles.windowWidth,
        height: widget.registerChallengePanelStyles.windowHeight,
        child: Theme(
          data: Theme.of(context).copyWith(brightness: Brightness.dark),
          child: CupertinoActivityIndicator(
            radius: widget.registerChallengePanelStyles.widthDp * 20,
          ),
        ),
      ),
    );
  }

  Widget _containerRegisteredPanel(BuildContext context) {
    return Container(
      width: widget.registerChallengePanelStyles.deviceWidth,
      height: widget.registerChallengePanelStyles.windowHeight,
      alignment: Alignment.center,
      child: Container(
        width: widget.registerChallengePanelStyles.windowWidth,
        height: widget.registerChallengePanelStyles.windowHeight,
        padding: EdgeInsets.symmetric(
          horizontal: widget.registerChallengePanelStyles.widthDp * 40,
          vertical: widget.registerChallengePanelStyles.heightDp * 25,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: widget.registerChallengePanelStyles.heightDp * 58,
                      height: widget.registerChallengePanelStyles.heightDp * 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check,
                        size: widget.registerChallengePanelStyles.heightDp * 50,
                        color: Color(0xFF5F5F5F),
                      ),
                    ),
                    SizedBox(height: widget.registerChallengePanelStyles.heightDp * 10),
                    Text(
                      "Registered!",
                      style: TextStyle(
                        fontSize: widget.registerChallengePanelStyles.fontSp * 20,
                        color: Colors.white,
                        fontFamily: "Avenir-HeavyOblique",
                      ),
                    ),
                    SizedBox(height: widget.registerChallengePanelStyles.heightDp * 5),
                    Text(
                      "Start your challenge anytime",
                      style: TextStyle(
                        fontSize: widget.registerChallengePanelStyles.fontSp * 18,
                        color: Colors.white,
                        fontFamily: "Avenir-Heavy",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.registerChallengePanelStyles.heightDp * 60),
                Text(
                  "*You will need to link\nyour bank account\nfor enjoying the prize of\nthe challenge!",
                  style: TextStyle(
                    fontSize: widget.registerChallengePanelStyles.fontSp * 20,
                    color: Color(0xFF74FFF5),
                    fontFamily: "Avenir-HeavyOblique",
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: widget.registerChallengePanelStyles.heightDp * 90),
                Column(
                  children: [
                    KeicyRaisedButton(
                      width: widget.registerChallengePanelStyles.widthDp * 168,
                      height: widget.registerChallengePanelStyles.heightDp * 42,
                      borderRadius: widget.registerChallengePanelStyles.heightDp * 21,
                      color: Color(0xFFE0E0E0),
                      elevation: 0,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: widget.registerChallengePanelStyles.fontSp * 17,
                          color: Color(0xFF0B0B0B),
                          fontFamily: "Avenir_Black",
                        ),
                      ),
                      onPressed: () {
                        RegisterChallengeProvider.of(context).setRegisterChallengeState(
                          RegisterChallengeProvider.of(context).registerChallengeState.update(step: 2),
                        );
                        Navigator.of(context).pop();
                        ChallengeListPanel().show(context, widget.campaignData);
                      },
                    ),
                    SizedBox(height: widget.registerChallengePanelStyles.heightDp * 28),
                    KeicyRaisedButton(
                      width: widget.registerChallengePanelStyles.widthDp * 226,
                      height: widget.registerChallengePanelStyles.heightDp * 42,
                      borderRadius: widget.registerChallengePanelStyles.heightDp * 21,
                      color: Color(0xFF1BF7E7).withOpacity(0.68),
                      elevation: 0,
                      child: Text(
                        "Link Your Bank Account",
                        style: TextStyle(
                          fontSize: widget.registerChallengePanelStyles.fontSp * 16,
                          color: Colors.white,
                          fontFamily: "Avenir-Medium",
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) => LinkBankAccountPage()),
                        );
                      },
                    ),
                    SizedBox(height: widget.registerChallengePanelStyles.heightDp * 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerCloseButton(BuildContext context) {
    return KeicyRaisedButton(
      width: widget.registerChallengePanelStyles.widthDp * 132,
      height: widget.registerChallengePanelStyles.heightDp * 35,
      color: Colors.white.withOpacity(0.1),
      borderColor: AppColors.whiteColor,
      borderRadius: widget.registerChallengePanelStyles.heightDp * 18,
      child: Text("Close", style: widget.registerChallengePanelStyles.closeButtonTextStyle),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
