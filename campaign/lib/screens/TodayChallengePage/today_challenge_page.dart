import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:campaign/providers/index.dart';
import 'index.dart';

class TodayChallengePage extends StatelessWidget {
  TodayChallengePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodayChallengePageStyles _todayChallengePageStyles = TodayChallengePageMobileStyles(context);

    return TodayChallengeView(todayChallengePageStyles: _todayChallengePageStyles);
  }
}
