import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:campaign/providers/HomePageProvider/index.dart';
import 'package:campaign/providers/RegisterChallengeProvider/index.dart';
import 'package:campaign/screens/ChallengeListPanel/index.dart';
import 'package:campaign/screens/ProfilePage/profile_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keicy_network_image/keicy_network_image.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../App/index.dart';

import 'index.dart';

class HomeView extends StatefulWidget {
  final HomePageStyles homePageStyles;

  const HomeView({
    Key key,
    this.homePageStyles,
  }) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomeView> with TickerProviderStateMixin {
  int bannerFlag;
  PageController pageController;
  Timer _timer;

  HomePageProvider _homePageProvider;

  @override
  void initState() {
    super.initState();

    bannerFlag = 0;
    pageController = new PageController();
    _homePageProvider = HomePageProvider.of(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homePageProvider.getCampaignListData();
      _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        if (_homePageProvider.homePageState.campaignListData["success"]) {
          pageController.animateToPage(
            ((pageController.page + 1) % 2).toInt(),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
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
        height: widget.homePageStyles.deviceHeight,
        child: Stack(
          children: [
            _containerBackgroud(context),
            Container(
              width: widget.homePageStyles.deviceWidth,
              height: widget.homePageStyles.mainHeight,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: widget.homePageStyles.deviceHeight - kBottomNavigationBarHeight,
                      child: _containerBackgroud(context),
                    ),
                    _containerHeaderPanel(context),
                    Container(
                      width: widget.homePageStyles.deviceWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: widget.homePageStyles.heightDp * 181),
                          _containerChart(context),
                          SizedBox(height: widget.homePageStyles.heightDp * 14),
                          _containerCategory(context),
                          SizedBox(height: widget.homePageStyles.heightDp * 16),
                          _containerButtons(context),
                          SizedBox(height: widget.homePageStyles.heightDp * 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<HomePageProvider>(builder: (context, homePageProvider, _) {
              if (!homePageProvider.homePageState.campaignListData["success"])
                return Text(
                  homePageProvider.homePageState.campaignListData["data"].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: 3,
                );
              List<Widget> bannerList = [];

              for (var i = 0; i < homePageProvider.homePageState.campaignListData["data"].length; i++) {
                bannerList.add(
                  _containerBannerPanel(context, homePageProvider.homePageState.campaignListData["data"][i]),
                );
              }

              return Positioned(
                bottom: widget.homePageStyles.bottombarHeight,
                child: Column(
                  children: [
                    Text(homePageProvider.homePageState.errorString, style: TextStyle(fontSize: 20)),
                    Container(
                      width: widget.homePageStyles.deviceWidth,
                      height: widget.homePageStyles.newsPanelHeight * 1.2,
                      alignment: Alignment.bottomCenter,
                      child: PageView(
                        controller: pageController,
                        children: bannerList,
                      ),
                    ),
                  ],
                ),
              );
            }),
            // _containerFloatingButton(context),
          ],
        ),
      ),
    );
  }

  Widget _containerHeaderPanel(BuildContext context) {
    return ClipPath(
      child: Container(
        width: widget.homePageStyles.deviceWidth,
        height: widget.homePageStyles.headerHeight,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.hardLight,
          color: Color(0xFF25B49E).withOpacity(0.6),
        ),
        child: Column(
          children: [
            SizedBox(height: widget.homePageStyles.heightDp * 51),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: widget.homePageStyles.widthDp * 37),
                  child: Image.asset(
                    AppAssets.menuIcon,
                    width: widget.homePageStyles.heightDp * 28.6,
                    height: widget.homePageStyles.heightDp * 19.25,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: widget.homePageStyles.widthDp * 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("20 MAR 2020", style: widget.homePageStyles.dateStyle),
                      SizedBox(height: widget.homePageStyles.heightDp * 10),
                      Text("Hello!", style: widget.homePageStyles.helloStyle),
                      Text("First Name!", style: widget.homePageStyles.nameStyle),
                      SizedBox(height: widget.homePageStyles.heightDp * 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                        },
                        child: Container(
                          width: widget.homePageStyles.heightDp * 40,
                          height: widget.homePageStyles.heightDp * 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xFF091F25), width: widget.homePageStyles.heightDp * 5),
                            color: Color(0xFF2F2E2E),
                          ),
                          child: Center(
                            child: Text("J", style: widget.homePageStyles.avatarUserNameStyle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// circle
                Container(
                  padding: EdgeInsets.only(right: widget.homePageStyles.widthDp * 8),
                  child: Column(
                    children: [
                      SizedBox(height: widget.homePageStyles.heightDp * 5),
                      Stack(
                        children: [
                          Container(
                            width: widget.homePageStyles.heightDp * 111,
                            height: widget.homePageStyles.heightDp * 111,
                          ),
                          Positioned(
                            top: widget.homePageStyles.heightDp * 2,
                            child: Container(
                              width: widget.homePageStyles.heightDp * 108,
                              height: widget.homePageStyles.heightDp * 108,
                              padding: EdgeInsets.symmetric(horizontal: widget.homePageStyles.heightDp * 28),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF2CA59D), Color(0xFF26ACBD)],
                                  stops: [0, 1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "sdfsdfsadf asdad asdas asd asda dada",
                                    style: widget.homePageStyles.dueDescriptionStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: widget.homePageStyles.heightDp * 5),
                                  Text(
                                    "Due to",
                                    style: widget.homePageStyles.dueLabelStyle,
                                  ),
                                  Text(
                                    "30 Mar",
                                    style: widget.homePageStyles.dueTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: widget.homePageStyles.heightDp * 3,
                            child: Container(
                              width: widget.homePageStyles.heightDp * 29,
                              height: widget.homePageStyles.heightDp * 29,
                              decoration: BoxDecoration(
                                color: Color(0xFF349BB7),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.restaurant,
                                  size: widget.homePageStyles.heightDp * 15,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: widget.homePageStyles.heightDp * 8),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      clipper: CustomClipPath(widget.homePageStyles.widthDp),
    );
  }

  Widget _containerBannerPanel(BuildContext context, Map<String, dynamic> bannerData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            RegisterChallengeProvider.of(context).setRegisterChallengeState(RegisterChallengeState.init(), isNotifiable: false);
            ChallengeListPanel().show(context, bannerData);
          },
          child: KeicyNetworkImage(
            url: bannerData["banner"],
            width: widget.homePageStyles.deviceWidth,
            height: widget.homePageStyles.newsPanelHeight * 1.2,
            borderColor: Colors.transparent,
            boxFit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget _containerBackgroud(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.backImage2,
          width: widget.homePageStyles.deviceWidth,
          height: widget.homePageStyles.deviceHeight,
          fit: BoxFit.cover,
        ),
        Image.asset(
          AppAssets.backImage1,
          width: widget.homePageStyles.deviceWidth,
          height: widget.homePageStyles.deviceHeight,
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.hardLight,
        ),
      ],
    );
  }

  Widget _containerChart(BuildContext context) {
    double chatContainerRadius = widget.homePageStyles.heightDp * 304;
    return ClipRRect(
      borderRadius: BorderRadius.circular(chatContainerRadius / 2),
      child: Container(
        width: chatContainerRadius,
        height: chatContainerRadius,
        decoration: BoxDecoration(color: Color(0xFF518B9B).withOpacity(0.6), shape: BoxShape.circle),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Stack(
            children: [
              _containerPieChatWithBlur(context),
              // Container(
              //   width: chatContainerRadius,
              //   height: chatContainerRadius,
              //   child: Center(
              //     child: Container(
              //       width: widget.homePageStyles.heightDp * 195,
              //       height: widget.homePageStyles.heightDp * 195,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         color: Color(0xFF9CCBC4).withOpacity(0.0),
              //         shape: BoxShape.circle,
              //         boxShadow: [
              //           BoxShadow(color: Color(0xFF9CCBC4).withOpacity(0.1), blurRadius: 6),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: chatContainerRadius,
                height: chatContainerRadius,
                child: Opacity(
                  opacity: 0.1,
                  child: Center(
                    child: Image.asset(
                      AppAssets.chartCenterImage,
                      width: widget.homePageStyles.heightDp * 215,
                      height: widget.homePageStyles.heightDp * 215,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: chatContainerRadius,
                height: chatContainerRadius,
                padding: EdgeInsets.all(widget.homePageStyles.heightDp * 68),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total Expenditure",
                        style: TextStyle(fontSize: widget.homePageStyles.fontSp * 12, fontFamily: "Avenir-Medium", color: Color(0xFFC6C6C6)),
                      ),
                      Text(
                        "\$10,123",
                        style: TextStyle(
                          fontSize: widget.homePageStyles.fontSp * 43,
                          fontFamily: "Avenir-Black",
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: widget.homePageStyles.heightDp * 10),
                      Text(
                        "Remaining Budget",
                        style: TextStyle(fontSize: widget.homePageStyles.fontSp * 12, fontFamily: "Avenir-Medium", color: Color(0xFFC6C6C6)),
                      ),
                      // SizedBox(height: widget.homePageStyles.heightDp * 5),
                      Text(
                        "\$100",
                        style: TextStyle(
                          fontSize: widget.homePageStyles.fontSp * 40,
                          fontFamily: "Avenir-Black",
                          color: Color(0xFF00FFD7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerCategory(BuildContext context) {
    return Container(
      width: widget.homePageStyles.widthDp * 252,
      height: widget.homePageStyles.heightDp * 53,
      padding: EdgeInsets.symmetric(
        horizontal: widget.homePageStyles.heightDp * 7,
        vertical: widget.homePageStyles.heightDp * 7,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF397A8E),
        borderRadius: BorderRadius.circular(widget.homePageStyles.heightDp * 28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widget.homePageStyles.widthDp * 42,
            height: widget.homePageStyles.widthDp * 42,
            child: Stack(
              children: [
                Container(
                  width: widget.homePageStyles.widthDp * 42,
                  height: widget.homePageStyles.widthDp * 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFED6D6D),
                      width: widget.homePageStyles.widthDp * 3,
                    ),
                    color: Color(0xFFFF7B7B),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "ALL",
                    style: TextStyle(
                      fontSize: widget.homePageStyles.fontSp * 15,
                      fontFamily: "Avenir-Heavy",
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: widget.homePageStyles.widthDp * 60,
                height: widget.homePageStyles.heightDp * 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.homePageStyles.heightDp * 5),
                  color: Color(0xFF959595),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "HSBC",
                  style: TextStyle(
                    fontSize: widget.homePageStyles.fontSp * 15,
                    color: AppColors.whiteColor,
                    fontFamily: "Avenir-Roman",
                  ),
                ),
              ),
              SizedBox(width: widget.homePageStyles.widthDp * 7),
              Container(
                width: widget.homePageStyles.widthDp * 60,
                height: widget.homePageStyles.heightDp * 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.homePageStyles.heightDp * 5),
                  color: Color(0xFF959595),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Hang\nSeng",
                  style: TextStyle(
                    fontSize: widget.homePageStyles.fontSp * 13,
                    color: AppColors.whiteColor,
                    height: 1,
                    fontFamily: "Avenir-Roman",
                  ),
                ),
              ),
            ],
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            strokeWidth: widget.homePageStyles.widthDp * 2,
            color: AppColors.whiteColor,
            radius: Radius.circular(widget.homePageStyles.heightDp * 21),
            padding: EdgeInsets.zero,
            strokeCap: StrokeCap.round,
            dashPattern: [3, 6],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.homePageStyles.heightDp * 21),
              child: Container(
                width: widget.homePageStyles.heightDp * 42,
                height: widget.homePageStyles.heightDp * 42,
                child: Center(
                  child: Icon(
                    Icons.person_add,
                    color: AppColors.whiteColor,
                    size: widget.homePageStyles.heightDp * 28,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _containerButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widget.homePageStyles.heightDp * 44,
          height: widget.homePageStyles.heightDp * 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2C8087),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.button1Icon,
              width: widget.homePageStyles.heightDp * 33,
              height: widget.homePageStyles.heightDp * 33,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: widget.homePageStyles.widthDp * 12),
        Container(
          width: widget.homePageStyles.heightDp * 44,
          height: widget.homePageStyles.heightDp * 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2C8087),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.eyeIcon,
              width: widget.homePageStyles.heightDp * 18,
              height: widget.homePageStyles.heightDp * 18,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: widget.homePageStyles.widthDp * 12),
        Container(
          width: widget.homePageStyles.heightDp * 44,
          height: widget.homePageStyles.heightDp * 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2C8087),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: widget.homePageStyles.heightDp * 33,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _containerFloatingButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: widget.homePageStyles.widthDp * 12,
          bottom: widget.homePageStyles.bottombarHeight + widget.homePageStyles.newsPanelHeight + widget.homePageStyles.heightDp * 8,
          child: Stack(
            children: [
              Container(
                width: widget.homePageStyles.heightDp * 75,
                height: widget.homePageStyles.heightDp * 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF2DDBCE), Color(0xFFCECE07)],
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.noteIcon,
                    width: widget.homePageStyles.heightDp * 25,
                    height: widget.homePageStyles.heightDp * 25,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: widget.homePageStyles.heightDp * 22,
                  height: widget.homePageStyles.heightDp * 22,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: widget.homePageStyles.fontSp * 17,
                        color: Color(0xFFFF7474),
                        fontFamily: "Avenir-Black",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _containerPieChatWithBlur(BuildContext context) {
    Map<String, double> dataMap = {
      "Flutter": 5,
      "space1": 0.2,
      "React": 3,
      "space2": 0.2,
      "Xamarin": 2,
      "space3": 0.2,
      "Ionic": 2,
      "space4": 0.2,
    };

    List<Color> colorList = [
      Color(0xFFE42A4C).withOpacity(0.93),
      Colors.transparent,
      Color(0xFF00C5A7).withOpacity(0.91),
      Colors.transparent,
      Color(0xFFFF889B).withOpacity(0.93),
      Colors.transparent,
      Color(0xFFF4C648).withOpacity(0.91),
      Colors.transparent,
    ];

    List<Color> shadowColorList = [
      Color(0xFF2E0606).withOpacity(0.44),
      Colors.transparent,
      Color(0xFF2E0606).withOpacity(0.44),
      Colors.transparent,
      Color(0xFF2E0606).withOpacity(0.44),
      Colors.transparent,
      Color(0xFF2E0606).withOpacity(0.44),
      Colors.transparent,
    ];
    return Stack(
      children: [
        Opacity(
          opacity: 0.47,
          child: Stack(
            children: [
              PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 100,
                chartRadius: widget.homePageStyles.heightDp * 240,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: false,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),
                ringStrokeWidth: widget.homePageStyles.heightDp * 33,
              ),
              Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Stack(
            children: [
              PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 100,
                chartRadius: widget.homePageStyles.heightDp * 240,
                colorList: shadowColorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: false,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),
                ringStrokeWidth: widget.homePageStyles.heightDp * 33,
              ),
              Container(
                width: widget.homePageStyles.heightDp * 300,
                height: widget.homePageStyles.heightDp * 300,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ],
          ),
        ),
        PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 100,
          chartRadius: widget.homePageStyles.heightDp * 240,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: false,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
          ),
          ringStrokeWidth: widget.homePageStyles.heightDp * 33,
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  double widthDp;
  double heightDp;

  CustomClipPath(this.widthDp);
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(-widthDp * 60, 0);
    path.lineTo(0, size.height);
    path.cubicTo(
      widthDp * 60,
      size.height,
      widthDp * 80,
      widthDp * 160,
      widthDp * 186,
      widthDp * 160,
    );
    path.cubicTo(
      widthDp * 286,
      widthDp * 160,
      widthDp * 270,
      widthDp * 240,
      size.width,
      widthDp * 192,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
