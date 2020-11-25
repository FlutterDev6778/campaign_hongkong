import 'dart:math';
import 'dart:ui';

import 'package:campaign/screens/App/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'index.dart';

class TempView extends StatefulWidget {
  final TempPageStyles tempPageStyles;
  final String title;

  const TempView({
    Key key,
    this.tempPageStyles,
    this.title,
  }) : super(key: key);

  @override
  _TempViewState createState() => _TempViewState();
}

class _TempViewState extends State<TempView> {
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
          width: widget.tempPageStyles.deviceWidth,
          height: widget.tempPageStyles.deviceHeight,
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
          child: Center(child: Text(widget.title, style: widget.tempPageStyles.headerStyle)),
        ),
      ),
    );
  }
}
