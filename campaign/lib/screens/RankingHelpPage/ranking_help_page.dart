import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class RankingHelpPage extends StatelessWidget {
  RankingHelpPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RankingHelpPageStyles _rankingHelpPageStyles = RankingHelpPageMobileStyles(context);

    return RankingHelpView(rankingHelpPageStyles: _rankingHelpPageStyles);
  }
}
