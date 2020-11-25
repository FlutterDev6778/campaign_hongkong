import 'package:campaign/providers/HomePageProvider/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageStyles _homePageStyles = HomePageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ],
      child: HomeView(homePageStyles: _homePageStyles),
    );
  }
}
