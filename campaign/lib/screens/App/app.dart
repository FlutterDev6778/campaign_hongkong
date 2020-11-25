import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../BottomNavbar/index.dart';
import '../../providers/index.dart';

import 'index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CompletedTasksProvider()),
        ChangeNotifierProvider(create: (_) => RegisterChallengeProvider()),
        ChangeNotifierProvider(create: (_) => TodayTasksProvider()),
      ],
      child: MaterialApp(
        theme: buildThemeData(context),
        routes: {
          AppRoutes.RootPage: (context) => BottomNavbar(),
        },
      ),
    );
  }
}
