import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../App/index.dart';

import 'index.dart';

class ReferralView extends StatefulWidget {
  final ReferralPageStyles referralPageStyles;

  const ReferralView({
    Key key,
    this.referralPageStyles,
  }) : super(key: key);

  @override
  _ReferralViewState createState() => _ReferralViewState();
}

class _ReferralViewState extends State<ReferralView> {
  bool isOpened;

  @override
  void initState() {
    super.initState();
    isOpened = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Hong Kong",
      "Asia",
      "Europe",
      "North America",
    ];

    return Scaffold(
      body: Container(
        width: widget.referralPageStyles.deviceWidth,
        height: widget.referralPageStyles.deviceHeight,
        child: Stack(
          children: [
            _containerBackground(context),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.referralPageStyles.statusbarHeight + widget.referralPageStyles.heightDp * 10,
                  ),
                  _containerAppBar(context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.referralPageStyles.widthDp * 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: widget.referralPageStyles.heightDp * 20),
                        _containerTitle(context),
                        SizedBox(height: widget.referralPageStyles.heightDp * 35),
                        _containerYourCode(context),
                        SizedBox(height: widget.referralPageStyles.heightDp * 35),
                        GestureDetector(
                          onTap: () {
                            Share.share("Here's the Areix app link: bit.ly/lolololol231");
                          },
                          child: KeicyRaisedButton(
                            width: widget.referralPageStyles.widthDp * 130,
                            height: widget.referralPageStyles.heightDp * 35,
                            color: Color(0xFF00F6D5).withOpacity(0.58),
                            borderRadius: widget.referralPageStyles.heightDp * 18,
                            child: Text(
                              "Share now!",
                              style: TextStyle(
                                fontSize: widget.referralPageStyles.fontSp * 17,
                                color: Colors.white,
                                fontFamily: "Avenir-Book",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: widget.referralPageStyles.heightDp * 35),
                        KeicyTextFormField(
                          width: null,
                          height: widget.referralPageStyles.heightDp * 44,
                          widthDp: widget.referralPageStyles.widthDp,
                          border: Border.all(color: Colors.transparent),
                          errorBorder: Border.all(color: Colors.red),
                          borderRadius: widget.referralPageStyles.heightDp * 12,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentHorizontalPadding: widget.referralPageStyles.widthDp * 20,
                          fixedHeightState: false,
                          textStyle: TextStyle(
                            fontSize: widget.referralPageStyles.fontSp * 17,
                            color: Colors.white,
                            fontFamily: "Avenir-Book",
                          ),
                        ),
                        SizedBox(height: widget.referralPageStyles.heightDp * 23),
                        KeicyRaisedButton(
                          width: widget.referralPageStyles.widthDp * 130,
                          height: widget.referralPageStyles.heightDp * 35,
                          color: Color(0xFF00F6D5).withOpacity(0.58),
                          borderRadius: widget.referralPageStyles.heightDp * 18,
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: widget.referralPageStyles.fontSp * 17,
                              color: Colors.white,
                              fontFamily: "Avenir-Book",
                            ),
                          ),
                        ),
                        SizedBox(height: widget.referralPageStyles.heightDp * 52),
                        isOpened
                            ? Container(
                                width: widget.referralPageStyles.widthDp * 285,
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.referralPageStyles.widthDp * 13,
                                  vertical: widget.referralPageStyles.heightDp * 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(widget.referralPageStyles.heightDp * 17),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isOpened = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Referral list",
                                            style: TextStyle(
                                              fontSize: widget.referralPageStyles.fontSp * 13,
                                              color: Colors.white,
                                              fontFamily: "Avenir-Light",
                                            ),
                                          ),
                                          SizedBox(width: widget.referralPageStyles.widthDp * 10),
                                          Icon(
                                            Icons.keyboard_arrow_up,
                                            size: widget.referralPageStyles.heightDp * 20,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: widget.referralPageStyles.heightDp * 10),
                                    Column(
                                      children: List.filled(3, 0).map(
                                        (data) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "*1923847#",
                                                    style: TextStyle(
                                                      fontSize: widget.referralPageStyles.fontSp * 12,
                                                      color: Colors.white,
                                                      fontFamily: "Avenir-Book",
                                                    ),
                                                  ),
                                                  Text(
                                                    "12/09/2020 18:02",
                                                    style: TextStyle(
                                                      fontSize: widget.referralPageStyles.fontSp * 12,
                                                      color: Colors.white,
                                                      fontFamily: "Avenir-Book",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: widget.referralPageStyles.heightDp * 5),
                                            ],
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOpened = true;
                                  });
                                },
                                child: Container(
                                  width: widget.referralPageStyles.widthDp * 112,
                                  // height: widget.referralPageStyles.widthDp * 33,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widget.referralPageStyles.widthDp * 13,
                                    vertical: widget.referralPageStyles.heightDp * 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(widget.referralPageStyles.heightDp * 17),
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Referral list",
                                        style: TextStyle(
                                          fontSize: widget.referralPageStyles.fontSp * 13,
                                          color: Colors.white,
                                          fontFamily: "Avenir-Light",
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        size: widget.referralPageStyles.heightDp * 20,
                                        color: Colors.white,
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
            )
          ],
        ),
      ),
    );
  }

  Widget _containerBackground(BuildContext context) {
    return Container(
      width: widget.referralPageStyles.deviceWidth,
      height: widget.referralPageStyles.deviceHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.referralBackImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _containerAppBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.referralPageStyles.widthDp * 25),
        child: Icon(
          Icons.arrow_back_ios,
          size: widget.referralPageStyles.widthDp * 22,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _containerTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          "Referral",
          style: TextStyle(fontSize: widget.referralPageStyles.fontSp * 30, color: Colors.white, fontFamily: "Avenir-Heavy"),
        )
      ],
    );
  }

  Widget _containerYourCode(BuildContext context) {
    return Row(
      children: [
        Text(
          "Your referral code : ",
          style: TextStyle(fontSize: widget.referralPageStyles.fontSp * 12, color: Colors.white, fontFamily: "Avenir-Heavy"),
        ),
        Expanded(
          child: Text(
            " 69904d92-b1f1-11ea-81a7-0a7a347b3dd5",
            style: TextStyle(
              fontSize: widget.referralPageStyles.fontSp * 15,
              color: Colors.white,
              fontFamily: "Avenir-Heavy",
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: widget.referralPageStyles.widthDp * 10),
        Center(
          child: GestureDetector(
            onTap: () {
              copyToClipbard(context);
            },
            child: Icon(
              Icons.content_copy,
              size: widget.referralPageStyles.heightDp * 22,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void copyToClipbard(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: widget.referralPageStyles.heightDp * 50, color: Colors.white),
              SizedBox(height: widget.referralPageStyles.widthDp * 5),
              Text(
                "Copied!",
                style: TextStyle(
                  fontSize: widget.referralPageStyles.fontSp * 20,
                  color: Colors.white,
                  fontFamily: "Avenir-HeavyOblique",
                ),
              ),
            ],
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }
}
