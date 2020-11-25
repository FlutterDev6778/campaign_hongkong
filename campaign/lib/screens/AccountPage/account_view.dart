import 'dart:math';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../App/index.dart';

import 'index.dart';

class AccountView extends StatefulWidget {
  final AccountPageStyles accountPageStyles;

  const AccountView({
    Key key,
    this.accountPageStyles,
  }) : super(key: key);

  @override
  _TransferViewState createState() => _TransferViewState();
}

class _TransferViewState extends State<AccountView> {
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
    return Scaffold(
      body: Container(
        height: widget.accountPageStyles.deviceHeight,
        child: Stack(
          children: [
            _containerBackgroud(context),
            Container(
              width: widget.accountPageStyles.deviceWidth,
              height: widget.accountPageStyles.mainHeight,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    _containerHeaderPanel(context),
                    Container(
                      width: widget.accountPageStyles.deviceWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: widget.accountPageStyles.widthDp * 181),
                          _containerChart(context),
                          SizedBox(height: widget.accountPageStyles.widthDp * 15),
                          _containerCategory(context),
                          SizedBox(height: widget.accountPageStyles.widthDp * 16),
                          _containerButtons(context),
                          SizedBox(height: widget.accountPageStyles.widthDp * 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _containerHSBCBannerPanel(context),
            _containerFloatingButton(context),
          ],
        ),
      ),
    );
  }

  Widget _containerHeaderPanel(BuildContext context) {
    return ClipPath(
      child: Container(
        width: widget.accountPageStyles.deviceWidth,
        height: widget.accountPageStyles.headerHeight,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.hardLight,
          color: Color(0xFF25B49E).withOpacity(0.6),
        ),
        child: Column(
          children: [
            SizedBox(height: widget.accountPageStyles.widthDp * 51),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: widget.accountPageStyles.widthDp * 37),
                  child: Image.asset(
                    AppAssets.menuIcon,
                    width: widget.accountPageStyles.widthDp * 28.6,
                    height: widget.accountPageStyles.widthDp * 19.25,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: widget.accountPageStyles.widthDp * 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("20 MAR 2020", style: widget.accountPageStyles.dateStyle),
                      SizedBox(height: widget.accountPageStyles.widthDp * 10),
                      Text("Hello!", style: widget.accountPageStyles.helloStyle),
                      Text("First Name!", style: widget.accountPageStyles.nameStyle),
                      SizedBox(height: widget.accountPageStyles.widthDp * 10),
                      Container(
                        width: widget.accountPageStyles.widthDp * 40,
                        height: widget.accountPageStyles.widthDp * 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xFF091F25), width: widget.accountPageStyles.widthDp * 5),
                          color: Color(0xFF2F2E2E),
                        ),
                        child: Center(
                          child: Text("J", style: widget.accountPageStyles.avatarUserNameStyle),
                        ),
                      ),
                    ],
                  ),
                ),

                /// circle
                Container(
                  padding: EdgeInsets.only(right: widget.accountPageStyles.widthDp * 8),
                  child: Column(
                    children: [
                      SizedBox(height: widget.accountPageStyles.widthDp * 5),
                      Stack(
                        children: [
                          Container(
                            width: widget.accountPageStyles.widthDp * 111,
                            height: widget.accountPageStyles.widthDp * 111,
                          ),
                          Positioned(
                            top: widget.accountPageStyles.widthDp * 2,
                            child: Container(
                              width: widget.accountPageStyles.widthDp * 108,
                              height: widget.accountPageStyles.widthDp * 108,
                              padding: EdgeInsets.symmetric(horizontal: widget.accountPageStyles.widthDp * 28),
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
                                    style: widget.accountPageStyles.dueDescriptionStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: widget.accountPageStyles.widthDp * 5),
                                  Text(
                                    "Due to",
                                    style: widget.accountPageStyles.dueLabelStyle,
                                  ),
                                  Text(
                                    "30 Mar",
                                    style: widget.accountPageStyles.dueTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: widget.accountPageStyles.widthDp * 3,
                            child: Container(
                              width: widget.accountPageStyles.widthDp * 29,
                              height: widget.accountPageStyles.widthDp * 29,
                              decoration: BoxDecoration(
                                color: Color(0xFF349BB7),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.restaurant,
                                  size: widget.accountPageStyles.widthDp * 15,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: widget.accountPageStyles.widthDp * 8),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      clipper: CustomClipPath(widget.accountPageStyles.widthDp),
    );
  }

  Widget _containerHSBCBannerPanel(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: widget.accountPageStyles.bottombarHeight,
          child: Container(
            width: widget.accountPageStyles.deviceWidth,
            height: widget.accountPageStyles.newsPanelHeight,
            padding: EdgeInsets.only(left: widget.accountPageStyles.widthDp * 18.5),
            decoration: BoxDecoration(
              color: Color(0xFF67928D),
              image: DecorationImage(image: AssetImage(AppAssets.dottedBack), fit: BoxFit.fill),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE8FF3B).withOpacity(0.45),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.arrowIcon,
                  width: widget.accountPageStyles.widthDp * 45,
                  height: widget.accountPageStyles.widthDp * 45,
                ),
                SizedBox(width: widget.accountPageStyles.widthDp * 5),
                Transform.rotate(
                  angle: pi,
                  child: SvgPicture.asset(
                    AppAssets.arrowIcon,
                    width: widget.accountPageStyles.widthDp * 45,
                    height: widget.accountPageStyles.widthDp * 45,
                  ),
                ),
                SizedBox(width: widget.accountPageStyles.widthDp * 12.5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("HSBC COMPITITION".toUpperCase(), style: widget.accountPageStyles.chanllengeLabelStyle),
                    SizedBox(height: widget.accountPageStyles.widthDp * 5),
                    Row(
                      children: [
                        SizedBox(width: widget.accountPageStyles.widthDp * 20),
                        Text("Be our best, Get HKD 50,000.".toUpperCase(), style: widget.accountPageStyles.chanllengedesciptionStyle),
                      ],
                    ),
                  ],
                )
              ],
            ),
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
          width: widget.accountPageStyles.deviceWidth,
          height: widget.accountPageStyles.deviceHeight,
          fit: BoxFit.cover,
        ),
        Image.asset(
          AppAssets.backImage1,
          width: widget.accountPageStyles.deviceWidth,
          height: widget.accountPageStyles.deviceHeight,
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.hardLight,
        ),
      ],
    );
  }

  Widget _containerChart(BuildContext context) {
    double chatContainerRadius = widget.accountPageStyles.widthDp * 304;
    return ClipRRect(
      borderRadius: BorderRadius.circular(chatContainerRadius / 2),
      child: Container(
        width: chatContainerRadius,
        height: chatContainerRadius,
        decoration: BoxDecoration(color: Color(0xFF518B9B).withOpacity(1), shape: BoxShape.circle),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Stack(
            children: [
              _containerPieChatWithBlur(context),
              Container(
                width: chatContainerRadius,
                height: chatContainerRadius,
                child: Center(
                  child: Container(
                    width: widget.accountPageStyles.widthDp * 195,
                    height: widget.accountPageStyles.widthDp * 195,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF9CCBC4).withOpacity(0.0),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0xFF9CCBC4).withOpacity(0.06), blurRadius: 6),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: chatContainerRadius,
                height: chatContainerRadius,
                padding: EdgeInsets.all(widget.accountPageStyles.widthDp * 68),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Expenditure",
                        style: TextStyle(fontSize: widget.accountPageStyles.fontSp * 12, fontFamily: "Avenir-Medium", color: Color(0xFFC6C6C6)),
                      ),
                      SizedBox(width: widget.accountPageStyles.widthDp * 5),
                      Text(
                        "\$10,123",
                        style: TextStyle(
                          fontSize: widget.accountPageStyles.fontSp * 43,
                          fontFamily: "Avenir-Black",
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: widget.accountPageStyles.widthDp * 15),
                      Text(
                        "Remaining Budget",
                        style: TextStyle(fontSize: widget.accountPageStyles.fontSp * 12, fontFamily: "Avenir-Medium", color: Color(0xFFC6C6C6)),
                      ),
                      SizedBox(height: widget.accountPageStyles.widthDp * 5),
                      Text(
                        "\$100",
                        style: TextStyle(
                          fontSize: widget.accountPageStyles.fontSp * 40,
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
      width: widget.accountPageStyles.widthDp * 252,
      height: widget.accountPageStyles.widthDp * 53,
      padding: EdgeInsets.symmetric(
        horizontal: widget.accountPageStyles.widthDp * 7,
        vertical: widget.accountPageStyles.widthDp * 5,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF397A8E),
        borderRadius: BorderRadius.circular(widget.accountPageStyles.widthDp * 27),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widget.accountPageStyles.widthDp * 42,
            height: widget.accountPageStyles.widthDp * 42,
            child: Stack(
              children: [
                Container(
                  width: widget.accountPageStyles.widthDp * 42,
                  height: widget.accountPageStyles.widthDp * 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFED6D6D),
                      width: widget.accountPageStyles.widthDp * 3,
                    ),
                    color: Color(0xFFFF7B7B),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "ALL",
                    style: TextStyle(
                      fontSize: widget.accountPageStyles.fontSp * 15,
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
                width: widget.accountPageStyles.widthDp * 60,
                height: widget.accountPageStyles.widthDp * 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.accountPageStyles.widthDp * 5),
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
                    fontSize: widget.accountPageStyles.fontSp * 15,
                    color: AppColors.whiteColor,
                    fontFamily: "Avenir-Roman",
                  ),
                ),
              ),
              SizedBox(width: widget.accountPageStyles.widthDp * 7),
              Container(
                width: widget.accountPageStyles.widthDp * 60,
                height: widget.accountPageStyles.widthDp * 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.accountPageStyles.widthDp * 5),
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
                    fontSize: widget.accountPageStyles.fontSp * 13,
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
            strokeWidth: widget.accountPageStyles.widthDp * 2,
            color: AppColors.whiteColor,
            radius: Radius.circular(widget.accountPageStyles.widthDp * 21),
            padding: EdgeInsets.zero,
            strokeCap: StrokeCap.round,
            dashPattern: [3, 6],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.accountPageStyles.widthDp * 21),
              child: Container(
                width: widget.accountPageStyles.widthDp * 42,
                height: widget.accountPageStyles.widthDp * 42,
                child: Center(
                  child: Icon(
                    Icons.person_add,
                    color: AppColors.whiteColor,
                    size: widget.accountPageStyles.widthDp * 28,
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
          width: widget.accountPageStyles.widthDp * 44,
          height: widget.accountPageStyles.widthDp * 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2C8087),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.button1Icon,
              width: widget.accountPageStyles.widthDp * 33,
              height: widget.accountPageStyles.widthDp * 33,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: widget.accountPageStyles.widthDp * 12),
        Container(
          width: widget.accountPageStyles.widthDp * 44,
          height: widget.accountPageStyles.widthDp * 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2C8087),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.eyeIcon,
              width: widget.accountPageStyles.widthDp * 18,
              height: widget.accountPageStyles.widthDp * 18,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: widget.accountPageStyles.widthDp * 12),
        Container(
          width: widget.accountPageStyles.widthDp * 44,
          height: widget.accountPageStyles.widthDp * 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2C8087),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: widget.accountPageStyles.widthDp * 33,
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
          right: widget.accountPageStyles.widthDp * 12,
          bottom: widget.accountPageStyles.bottombarHeight + widget.accountPageStyles.newsPanelHeight + widget.accountPageStyles.widthDp * 8,
          child: Stack(
            children: [
              Container(
                width: widget.accountPageStyles.widthDp * 75,
                height: widget.accountPageStyles.widthDp * 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF2DDBCE), Color(0xFFCECE07)],
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.noteIcon,
                    width: widget.accountPageStyles.widthDp * 25,
                    height: widget.accountPageStyles.widthDp * 25,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: widget.accountPageStyles.widthDp * 22,
                  height: widget.accountPageStyles.widthDp * 22,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: widget.accountPageStyles.fontSp * 17,
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
                chartRadius: widget.accountPageStyles.widthDp * 240,
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
                ringStrokeWidth: widget.accountPageStyles.widthDp * 33,
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
                chartRadius: widget.accountPageStyles.widthDp * 240,
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
                ringStrokeWidth: widget.accountPageStyles.widthDp * 33,
              ),
              Container(
                width: widget.accountPageStyles.widthDp * 300,
                height: widget.accountPageStyles.widthDp * 300,
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
          chartRadius: widget.accountPageStyles.widthDp * 240,
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
          ringStrokeWidth: widget.accountPageStyles.widthDp * 33,
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  double widthDp;

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
