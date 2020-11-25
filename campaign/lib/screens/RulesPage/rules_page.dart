import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class RulesPage extends StatelessWidget {
  RulesPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RulesPageStyles _rulesPageStyles = RulesPageMobileStyles(context);

    return RulesView(rulesPageStyles: _rulesPageStyles);
  }
}
