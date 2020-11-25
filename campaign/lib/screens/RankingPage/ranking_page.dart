import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class RankingPage extends StatelessWidget {
  RankingPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RankingPageStyles _rankingPageStyles = RankingPageMobileStyles(context);

    return RankingView(rankingPageStyles: _rankingPageStyles);
  }
}
