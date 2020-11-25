import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class WeeklyTaskListPage extends StatelessWidget {
  String weekDay;

  WeeklyTaskListPage({
    Key key,
    @required this.weekDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeeklyTaskListPageStyles _weeklyTaskListPageStyles = WeeklyTaskListPageMobileStyles(context);

    return WeeklyTaskListView(weeklyTaskListPageStyles: _weeklyTaskListPageStyles, weekDay: weekDay);
  }
}
