import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class WeekChallengePage extends StatelessWidget {
  WeekChallengePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeekChallengePageStyles _weekChallengePageStyles = WeekChallengePageMobileStyles(context);

    return WeekChallengeView(weekChallengePageStyles: _weekChallengePageStyles);
  }
}
