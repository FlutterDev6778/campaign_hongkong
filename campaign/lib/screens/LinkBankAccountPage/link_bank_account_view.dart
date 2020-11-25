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

import '../App/index.dart';

import 'index.dart';

class LinkBankAccountView extends StatefulWidget {
  final LinkBankAccountPageStyles linkBankAccountPageStyles;

  const LinkBankAccountView({
    Key key,
    this.linkBankAccountPageStyles,
  }) : super(key: key);

  @override
  _LinkBankAccountViewState createState() => _LinkBankAccountViewState();
}

class _LinkBankAccountViewState extends State<LinkBankAccountView> {
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
    List<String> list = [
      "Hong Kong",
      "Asia",
      "Europe",
      "North America",
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: widget.linkBankAccountPageStyles.deviceWidth,
          height: widget.linkBankAccountPageStyles.deviceHeight,
          child: Stack(
            children: [
              _containerBackground(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.linkBankAccountPageStyles.statusbarHeight + widget.linkBankAccountPageStyles.heightDp * 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: widget.linkBankAccountPageStyles.widthDp * 25),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: widget.linkBankAccountPageStyles.heightDp * 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.linkBankAccountPageStyles.widthDp * 36),
                    child: Column(
                      children: [
                        SizedBox(height: widget.linkBankAccountPageStyles.heightDp * 20),
                        Row(
                          children: [
                            Text(
                              "Get connected",
                              style: TextStyle(fontSize: widget.linkBankAccountPageStyles.fontSp, color: Colors.white, fontFamily: "Avenir-Heavy"),
                            )
                          ],
                        ),
                        SizedBox(height: widget.linkBankAccountPageStyles.heightDp * 28),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF314A73).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(widget.linkBankAccountPageStyles.itemBorderRadius),
                          ),
                          child: KeicyTextFormField(
                            width: widget.linkBankAccountPageStyles.itemWidth,
                            height: widget.linkBankAccountPageStyles.itemHeight,
                            widthDp: widget.linkBankAccountPageStyles.widthDp,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: widget.linkBankAccountPageStyles.itemBorderRadius,
                            contentHorizontalPadding: widget.linkBankAccountPageStyles.widthDp * 20,
                            textStyle: widget.linkBankAccountPageStyles.textStyle,
                            hintStyle: widget.linkBankAccountPageStyles.hintStyle,
                            fixedHeightState: false,
                          ),
                        ),
                        SizedBox(height: widget.linkBankAccountPageStyles.heightDp * 31),
                        Column(
                          children: list
                              .map(
                                (item) => Container(
                                  width: widget.linkBankAccountPageStyles.itemWidth,
                                  height: widget.linkBankAccountPageStyles.itemHeight,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF314A73).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(widget.linkBankAccountPageStyles.itemBorderRadius),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: widget.linkBankAccountPageStyles.heightDp * 3,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widget.linkBankAccountPageStyles.widthDp * 40,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(item, style: widget.linkBankAccountPageStyles.textStyle),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerBackground(BuildContext context) {
    return Container(
      width: widget.linkBankAccountPageStyles.deviceWidth,
      height: widget.linkBankAccountPageStyles.deviceHeight,
      child: Stack(
        children: [
          Container(
            width: widget.linkBankAccountPageStyles.deviceWidth,
            height: widget.linkBankAccountPageStyles.deviceHeight,
            color: Color(0xFF011D24),
          ),
          Container(
            width: widget.linkBankAccountPageStyles.deviceWidth,
            height: widget.linkBankAccountPageStyles.deviceHeight,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                AppAssets.linkBankBackImage1,
                width: widget.linkBankAccountPageStyles.deviceWidth,
                height: widget.linkBankAccountPageStyles.deviceHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: widget.linkBankAccountPageStyles.deviceWidth,
            height: widget.linkBankAccountPageStyles.deviceHeight,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                AppAssets.backImage1,
                width: widget.linkBankAccountPageStyles.deviceWidth,
                height: widget.linkBankAccountPageStyles.deviceHeight,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
