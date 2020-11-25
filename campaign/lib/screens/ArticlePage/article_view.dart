import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';

import '../App/index.dart';
import '../../providers/index.dart';

import 'index.dart';

class ArticleView extends StatefulWidget {
  final ArticlePageStyles articlePageStyles;
  final String cohort;

  const ArticleView({
    Key key,
    this.articlePageStyles,
    this.cohort,
  }) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  ArticleProvider _articleProvider;
  CompleteArticleTaskProvider _completeArticleTaskProvider;
  KeicyProgressDialog _keicyProgressDialog;

  @override
  void initState() {
    super.initState();

    _keicyProgressDialog = KeicyProgressDialog(context, message: "Please wait .....");
    _articleProvider = ArticleProvider.of(context);
    _completeArticleTaskProvider = CompleteArticleTaskProvider.of(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _articleProvider.getArticleData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: widget.articlePageStyles.deviceWidth,
            height: widget.articlePageStyles.deviceHeight,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: widget.articlePageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
                right: BorderSide(width: widget.articlePageStyles.greyBarWidth, color: Color(0xFFBFD7DF)),
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
          Consumer<CompleteArticleTaskProvider>(
            builder: (context, completeArticleTaskProvider, _) {
              if (completeArticleTaskProvider.completeArticleTaskState.progressState == 2) {
                return _showSuccessDialog(context);
              }

              if (completeArticleTaskProvider.completeArticleTaskState.progressState == 1) {
                return _showProgressing(context);
              }

              if (completeArticleTaskProvider.completeArticleTaskState.progressState == -1) {
                return _showFailDialog(context, completeArticleTaskProvider);
              }

              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Container(
      width: widget.articlePageStyles.deviceWidth,
      height: widget.articlePageStyles.deviceHeight,
      child: Stack(
        children: [
          _containerRectangles(context),
          Consumer<ArticleProvider>(builder: (context, articleProvider, _) {
            if (articleProvider.articleState.articleData["success"] == null) {
              return Column(
                children: [
                  SizedBox(height: widget.articlePageStyles.statusbarHeight),
                  _containerHeader(context),
                  Expanded(
                    child: Center(
                      child: KeicyCupertinoIndicator(brightness: Brightness.dark),
                    ),
                  ),
                ],
              );
            }
            if (!articleProvider.articleState.articleData["success"]) {
              return Column(
                children: [
                  SizedBox(height: widget.articlePageStyles.statusbarHeight),
                  _containerHeader(context),
                  Expanded(
                    child: Center(
                      child: Text(
                        articleProvider.articleState.articleData["data"] ??
                            articleProvider.articleState.articleData["msg"] ??
                            "Getting Article Data Error",
                        style: TextStyle(
                          fontSize: widget.articlePageStyles.fontSp * 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return _mainPanel(context, articleProvider);
          }),
        ],
      ),
    );
  }

  Widget _containerRectangles(BuildContext context) {
    return Positioned(
      left: -widget.articlePageStyles.heightDp * 5,
      top: widget.articlePageStyles.statusbarHeight - widget.articlePageStyles.heightDp * 50,
      child: Container(
        width: widget.articlePageStyles.deviceWidth,
        child: Image.asset(
          AppAssets.rectangleForRulePage,
          height: widget.articlePageStyles.heightDp * 160,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: widget.articlePageStyles.deviceWidth,
      child: Container(
        width: widget.articlePageStyles.deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: widget.articlePageStyles.widthDp * 23),
        child: Column(
          children: [
            SizedBox(height: widget.articlePageStyles.heightDp * 15),
            Text(
              "Wealth Article".toUpperCase(),
              style: TextStyle(
                fontSize: widget.articlePageStyles.fontSp * 20,
                fontFamily: "Avenir-Heavy",
                color: Colors.white,
                height: 1.2,
                shadows: [
                  BoxShadow(color: Color(0xFF002623), offset: Offset(0, 3), blurRadius: 6),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              AppAssets.companyLogo,
              width: widget.articlePageStyles.heightDp * 106,
              height: widget.articlePageStyles.heightDp * 106,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }

  Widget _mainPanel(BuildContext context, ArticleProvider articleProvider) {
    return Column(
      children: [
        SizedBox(height: widget.articlePageStyles.statusbarHeight),
        _containerHeader(context),
        _articleTitle(context, articleProvider),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.articlePageStyles.widthDp * 30,
              vertical: widget.articlePageStyles.heightDp * 25,
            ),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Text(
                articleProvider.articleState.articleData["data"]["article"]["CN"]["body"],
                style: TextStyle(
                  fontFamily: "Avenir-Heavy",
                  fontSize: widget.articlePageStyles.fontSp * 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        KeicyRaisedButton(
          width: widget.articlePageStyles.widthDp * 238,
          height: widget.articlePageStyles.heightDp * 45,
          borderRadius: widget.articlePageStyles.heightDp * 23,
          color: Color(0xFF37ADB7),
          elevation: 0,
          child: Text(
            "Read the full article",
            style: TextStyle(
              fontFamily: "Avenir-Medium",
              fontSize: widget.articlePageStyles.fontSp * 21,
              color: Color(0xFF10FFED),
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: widget.articlePageStyles.heightDp * 40),
        KeicyRaisedButton(
          width: widget.articlePageStyles.widthDp * 172,
          height: widget.articlePageStyles.heightDp * 45,
          borderRadius: widget.articlePageStyles.heightDp * 23,
          color: Color(0xFF37ADB7),
          elevation: 0,
          child: Text(
            "OK!",
            style: TextStyle(
              fontFamily: "Avenir-Medium",
              fontSize: widget.articlePageStyles.fontSp * 21,
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            _completeArticleTaskProvider.setCompleteArticleTaskState(
              _completeArticleTaskProvider.completeArticleTaskState.update(
                progressState: 1,
                errorString: "",
              ),
            );
            _completeArticleTaskProvider.getCompleteArticleTaskData(widget.cohort);
          },
        ),
        SizedBox(height: widget.articlePageStyles.heightDp * 10),
      ],
    );
  }

  Widget _articleTitle(BuildContext context, ArticleProvider articleProvider) {
    return Container(
      height: widget.articlePageStyles.heightDp * 72,
      padding: EdgeInsets.symmetric(horizontal: widget.articlePageStyles.widthDp * 15),
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
      alignment: Alignment.center,
      child: Text(
        articleProvider.articleState.articleData["data"]["article"]["CN"]["title"],
        style: TextStyle(
          fontFamily: "Avenir-Heavy",
          fontSize: widget.articlePageStyles.fontSp * 21,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _showSuccessDialog(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(true);
    });
    return Container(
      width: widget.articlePageStyles.deviceWidth,
      height: widget.articlePageStyles.deviceHeight,
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: widget.articlePageStyles.heightDp * 50,
            color: Colors.white,
          ),
          Text(
            "Completed!\nThank you.",
            style: TextStyle(
              fontFamily: "Avenir-HeavyOblique",
              fontSize: widget.articlePageStyles.fontSp * 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _showProgressing(BuildContext context) {
    return Container(
      width: widget.articlePageStyles.deviceWidth,
      height: widget.articlePageStyles.deviceHeight,
      color: Colors.black.withOpacity(0.7),
      alignment: Alignment.center,
      child: Center(
        child: KeicyCupertinoIndicator(
          brightness: Brightness.dark,
        ),
      ),
    );
  }

  Widget _showFailDialog(BuildContext context, CompleteArticleTaskProvider completeArticleTaskProvider) {
    Future.delayed(Duration(seconds: 2), () {
      completeArticleTaskProvider.setCompleteArticleTaskState(
        completeArticleTaskProvider.completeArticleTaskState.update(
          progressState: 0,
          errorString: "",
        ),
      );
    });

    return Container(
      width: widget.articlePageStyles.deviceWidth,
      height: widget.articlePageStyles.deviceHeight,
      color: Colors.black.withOpacity(0.7),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: widget.articlePageStyles.heightDp * 50,
            color: Colors.white,
          ),
          Text(
            completeArticleTaskProvider.completeArticleTaskState.completeArticleTaskData["data"],
            style: TextStyle(
              fontFamily: "Avenir-HeavyOblique",
              fontSize: widget.articlePageStyles.fontSp * 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
