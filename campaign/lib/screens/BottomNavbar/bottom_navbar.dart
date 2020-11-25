import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';

import '../App/index.dart';
import '../HomePage/index.dart';
import '../AccountPage/index.dart';

import 'index.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 1;
  BottomNavbarStyles _bottomNavbarStyles;

  @override
  void initState() {
    super.initState();
  }

  void onChangeTab(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavbarStyles = BottomNavbarMobileStyles(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBody: true,
        body: TabBarView(
          children: [
            HomePage(),
            AccountPage(),
            new Container(
              color: Colors.red,
            ),
            new Container(
              color: Colors.blueAccent,
            ),
          ],
        ),
        bottomNavigationBar: _containerBottomNavbar(context),
      ),
    );
  }

  Widget _containerBottomNavbar(BuildContext context) {
    return JumpingTabBar(
      onChangeTab: onChangeTab,
      height: _bottomNavbarStyles.bottomNavbarHeight,
      jumpHeight: _bottomNavbarStyles.widthDp * 25,
      duration: Duration(milliseconds: 700),
      backgroundColor: AppColors.whiteColor,
      circleGradient: LinearGradient(
        colors: [
          AppColors.whiteColor,
          AppColors.whiteColor,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      items: [
        TabItemIcon(
          curveColor: Colors.transparent,
          titleWidget: (context) {
            return Column(
              children: [
                Text(BottomNavbarString.homeLabel, style: _bottomNavbarStyles.bottomTextStyle),
                SizedBox(height: _bottomNavbarStyles.widthDp * 20),
              ],
            );
          },
          buildWidget: (context, _) {
            return Container(
              width: _bottomNavbarStyles.circularSize,
              height: _bottomNavbarStyles.circularSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.homeIcon,
                  width: _bottomNavbarStyles.iconSize,
                  height: _bottomNavbarStyles.iconSize,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        TabItemIcon(
          curveColor: Colors.transparent,
          titleWidget: (context) {
            return Column(
              children: [
                Text(BottomNavbarString.accountLabel, style: _bottomNavbarStyles.bottomTextStyle),
                SizedBox(height: _bottomNavbarStyles.widthDp * 20),
              ],
            );
          },
          buildWidget: (context, _) {
            return Container(
              width: _bottomNavbarStyles.circularSize,
              height: _bottomNavbarStyles.circularSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.accountIcon,
                  width: _bottomNavbarStyles.iconSize * 0.8,
                  height: _bottomNavbarStyles.iconSize * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        TabItemIcon(
          curveColor: Colors.transparent,
          titleWidget: (context) {
            return Column(
              children: [
                Text(BottomNavbarString.ibudgetLabel, style: _bottomNavbarStyles.bottomTextStyle),
                SizedBox(height: _bottomNavbarStyles.widthDp * 20),
              ],
            );
          },
          buildWidget: (context, _) {
            return Container(
              width: _bottomNavbarStyles.circularSize,
              height: _bottomNavbarStyles.circularSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.ibudgetIcon,
                  width: _bottomNavbarStyles.iconSize,
                  height: _bottomNavbarStyles.iconSize,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        TabItemIcon(
          curveColor: Colors.transparent,
          titleWidget: (context) {
            return Column(
              children: [
                Text(BottomNavbarString.marketLabel, style: _bottomNavbarStyles.bottomTextStyle),
                SizedBox(height: _bottomNavbarStyles.widthDp * 20),
              ],
            );
          },
          buildWidget: (context, _) {
            return Container(
              width: _bottomNavbarStyles.circularSize,
              height: _bottomNavbarStyles.circularSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.marketIcon,
                  width: _bottomNavbarStyles.iconSize * 0.8,
                  height: _bottomNavbarStyles.iconSize * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
      selectedIndex: selectedIndex,
    );
  }
}
