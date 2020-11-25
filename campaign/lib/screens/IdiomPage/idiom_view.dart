import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/RulesPage/index.dart';
import 'package:campaign/screens/WeekChallengePage/week_challenge_page.dart';
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

class IdiomView extends StatefulWidget {
  final IdiomPageStyles idiomPageStyles;

  const IdiomView({
    Key key,
    this.idiomPageStyles,
  }) : super(key: key);

  @override
  _IdiomViewState createState() => _IdiomViewState();
}

class _IdiomViewState extends State<IdiomView> with TickerProviderStateMixin {
  AnimationController _lineAnimationController;
  Animation _lineAnimationTween;

  AnimationController _hightLightAnimationController;
  Animation _hightLightAnimationTween;

  AnimationController _keyOpacityAnimationController;
  Animation _keyOpacityAnimationTween;

  AnimationController _keyMoveAniimationController;
  Animation _keyMoveAnimationTween;

  AnimationController _outline1OpacityAnimationController;
  Animation _outline1OpacityAnimationTween;

  @override
  void initState() {
    super.initState();

    _lineAnimationController = AnimationController(vsync: this);
    _lineAnimationTween = Tween<double>(
      begin: -widget.idiomPageStyles.widthDp * 300,
      end: -widget.idiomPageStyles.widthDp * 200,
    ).animate(_lineAnimationController);
    _lineAnimationController.duration = Duration(milliseconds: 500);
    _lineAnimationController.reverseDuration = Duration(milliseconds: 500);

    _hightLightAnimationController = AnimationController(vsync: this);
    _hightLightAnimationTween = Tween<double>(begin: 0, end: 1).animate(_hightLightAnimationController);
    _hightLightAnimationController.duration = Duration(milliseconds: 500);
    _hightLightAnimationController.reverseDuration = Duration(milliseconds: 300);

    _keyOpacityAnimationController = AnimationController(vsync: this);
    _keyOpacityAnimationTween = Tween<double>(begin: 0, end: 1).animate(_keyOpacityAnimationController);
    _keyOpacityAnimationController.duration = Duration(milliseconds: 500);
    _keyOpacityAnimationController.reverseDuration = Duration(milliseconds: 300);

    _keyMoveAniimationController = AnimationController(vsync: this);
    _keyMoveAnimationTween = Tween<double>(begin: 0, end: 1).animate(_keyMoveAniimationController);
    _keyMoveAniimationController.duration = Duration(milliseconds: 500);

    _outline1OpacityAnimationController = AnimationController(vsync: this);
    _outline1OpacityAnimationTween = Tween<double>(begin: 0, end: 1).animate(_outline1OpacityAnimationController);
    _outline1OpacityAnimationController.duration = Duration(milliseconds: 300);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lineAnimationController.forward();

      Future.delayed(Duration(milliseconds: 500), () {
        _hightLightAnimationController.forward();
      });

      Future.delayed(Duration(milliseconds: 1000), () {
        _keyOpacityAnimationController.forward();
      });

      Future.delayed(Duration(milliseconds: 1500), () {
        _keyMoveAniimationController.forward();
      });

      Future.delayed(Duration(milliseconds: 2200), () {
        _outline1OpacityAnimationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _lineAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.idiomPageStyles.deviceWidth,
        height: widget.idiomPageStyles.deviceHeight,
        color: Color(0xFF002129),
        child: Stack(
          children: [
            _containerOutline1(context),
            _containerHightLightLines(context),
            _containerLineBack(context),
            _containerKey(context),
            _containerMainRect(context),
            _containerOutline2(context),
            _containerTexts(context),
            Positioned(
              bottom: (widget.idiomPageStyles.deviceHeight - widget.idiomPageStyles.heightDp * 435) / 4,
              child: Container(
                width: widget.idiomPageStyles.deviceWidth,
                child: AnimatedBuilder(
                    animation: _outline1OpacityAnimationTween,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _outline1OpacityAnimationTween.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KeicyRaisedButton(
                              width: widget.idiomPageStyles.widthDp * 132,
                              height: widget.idiomPageStyles.heightDp * 35,
                              borderRadius: widget.idiomPageStyles.heightDp * 18,
                              color: Colors.white.withOpacity(0.68),
                              elevation: 0,
                              child: Text(
                                "CONTIUNE",
                                style: TextStyle(
                                  fontSize: widget.idiomPageStyles.fontSp * 16,
                                  color: Colors.black,
                                  fontFamily: "Avenir-Heavy",
                                ),
                              ),
                              onPressed: () {
                                print("sssssssss");
                                _outline1OpacityAnimationController.reverse();
                                _keyOpacityAnimationController.reverse();
                                Future.delayed(Duration(milliseconds: 300), () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => WeekChallengePage(),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerLineBack(BuildContext context) {
    return Container(
      width: widget.idiomPageStyles.deviceWidth,
      height: widget.idiomPageStyles.deviceHeight,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _lineAnimationTween,
            builder: (context, child) {
              return Positioned(
                top: _lineAnimationTween.value,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: widget.idiomPageStyles.deviceWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.idiomLineTop,
                          width: widget.idiomPageStyles.widthDp * 274,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _lineAnimationTween,
            builder: (context, child) {
              return Positioned(
                bottom: _lineAnimationTween.value,
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    width: widget.idiomPageStyles.deviceWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.idiomLineBottom,
                          width: widget.idiomPageStyles.widthDp * 274,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _containerHightLightLines(BuildContext context) {
    return Container(
      width: widget.idiomPageStyles.deviceWidth,
      height: widget.idiomPageStyles.deviceHeight,
      child: AnimatedBuilder(
          animation: _hightLightAnimationTween,
          builder: (context, child) {
            return Opacity(
              opacity: _hightLightAnimationTween.value,
              child: Stack(
                children: [
                  // Positioned(
                  //   left: widget.idiomPageStyles.widthDp * 38,
                  //   top: -widget.idiomPageStyles.widthDp * 120,
                  //   child: Opacity(
                  //     opacity: 0.5,
                  //     child: Image.asset(
                  //       AppAssets.hightLightVertical,
                  //       height: widget.idiomPageStyles.widthDp * 300,
                  //       fit: BoxFit.fitHeight,
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    left: widget.idiomPageStyles.widthDp * 25,
                    top: -widget.idiomPageStyles.heightDp * 100,
                    child: Opacity(
                      opacity: 1,
                      child: Image.asset(
                        AppAssets.hightLightVertical,
                        height: widget.idiomPageStyles.heightDp * 600,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    left: widget.idiomPageStyles.widthDp * 25,
                    bottom: -widget.idiomPageStyles.heightDp * 150,
                    child: Opacity(
                      opacity: 1,
                      child: Image.asset(
                        AppAssets.hightLightVertical,
                        height: widget.idiomPageStyles.heightDp * 600,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _containerKey(BuildContext context) {
    return AnimatedBuilder(
      animation: _keyOpacityAnimationTween,
      builder: (context, child) {
        return Opacity(
          opacity: _keyOpacityAnimationTween.value,
          child: AnimatedBuilder(
            animation: _keyMoveAnimationTween,
            builder: (context, child) {
              return Container(
                width: widget.idiomPageStyles.deviceWidth,
                height: widget.idiomPageStyles.deviceHeight,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: widget.idiomPageStyles.heightDp * 105),
                    SizedBox(height: widget.idiomPageStyles.heightDp * 230 * (1 - _keyMoveAnimationTween.value)),
                    Container(
                      width: widget.idiomPageStyles.heightDp * 85,
                      height: widget.idiomPageStyles.heightDp * 85,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 1 - _keyMoveAnimationTween.value,
                            child: Image.asset(
                              AppAssets.idiomKeyClose,
                              width: widget.idiomPageStyles.heightDp * 85,
                              height: widget.idiomPageStyles.heightDp * 85,
                              color: Color(0xFF10FFED),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Opacity(
                            opacity: _keyMoveAnimationTween.value,
                            child: Image.asset(
                              AppAssets.idiomKeyOpen,
                              width: widget.idiomPageStyles.heightDp * 85,
                              height: widget.idiomPageStyles.heightDp * 85,
                              color: Color(0xFF10FFED),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _containerOutline1(BuildContext context) {
    return AnimatedBuilder(
      animation: _outline1OpacityAnimationTween,
      builder: (context, child) {
        return ClipRect(
          child: Opacity(
            opacity: _outline1OpacityAnimationTween.value,
            child: Stack(
              children: [
                Container(
                  width: widget.idiomPageStyles.deviceWidth,
                  height: widget.idiomPageStyles.deviceHeight,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppAssets.idiomOutline1Image,
                    width: widget.idiomPageStyles.heightDp * 320,
                    height: widget.idiomPageStyles.heightDp * 435,
                    color: Color(0xFFC9E5DA),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: widget.idiomPageStyles.deviceWidth,
                  height: widget.idiomPageStyles.deviceHeight,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                Container(
                  width: widget.idiomPageStyles.deviceWidth,
                  height: widget.idiomPageStyles.deviceHeight,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.idiomOutline1Image,
                        width: widget.idiomPageStyles.heightDp * 320,
                        height: widget.idiomPageStyles.heightDp * 435,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _containerOutline2(BuildContext context) {
    return AnimatedBuilder(
      animation: _outline1OpacityAnimationTween,
      builder: (context, child) {
        return Opacity(
          opacity: _outline1OpacityAnimationTween.value,
          child: Container(
            width: widget.idiomPageStyles.deviceWidth,
            height: widget.idiomPageStyles.deviceHeight,
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.idiomOutline2Image,
              width: widget.idiomPageStyles.heightDp * 282,
              height: widget.idiomPageStyles.heightDp * (100 + 283 * _outline1OpacityAnimationTween.value),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _containerMainRect(BuildContext context) {
    return AnimatedBuilder(
      animation: _outline1OpacityAnimationTween,
      builder: (context, child) {
        return Opacity(
          opacity: _outline1OpacityAnimationTween.value,
          child: Container(
            width: widget.idiomPageStyles.deviceWidth,
            height: widget.idiomPageStyles.deviceHeight,
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.idiomMainRectImage,
              width: widget.idiomPageStyles.heightDp * 280,
              height: widget.idiomPageStyles.heightDp * (60 + 322 * _outline1OpacityAnimationTween.value),
              color: Color(0xFF466870),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _containerTexts(BuildContext context) {
    return AnimatedBuilder(
      animation: _outline1OpacityAnimationTween,
      builder: (context, child) {
        return Opacity(
          opacity: _outline1OpacityAnimationTween.value,
          child: Container(
            width: widget.idiomPageStyles.deviceWidth,
            height: widget.idiomPageStyles.deviceHeight,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: widget.idiomPageStyles.widthDp * 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Idiom shine".toUpperCase(),
                  style: TextStyle(
                    fontSize: widget.idiomPageStyles.fontSp * 26,
                    color: Colors.white,
                    fontFamily: "Avenir-HeavyOblique",
                  ),
                ),
                SizedBox(height: widget.idiomPageStyles.heightDp * 25),
                Text(
                  "Do you know that XXXXXXXXX XXXXXXXX.",
                  style: TextStyle(
                    fontSize: widget.idiomPageStyles.fontSp * 22,
                    color: Colors.white,
                    fontFamily: "Avenir-Heavy",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: widget.idiomPageStyles.heightDp * 15),
                Text(
                  "by ;aklsdjflkamsd,mf".toUpperCase(),
                  style: TextStyle(
                    fontSize: widget.idiomPageStyles.fontSp * 10,
                    color: Colors.white,
                    fontFamily: "Avenir-Light",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
