import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class IdiomPage extends StatelessWidget {
  IdiomPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IdiomPageStyles _idiomPageStyles = IdiomPageMobileStyles(context);

    return IdiomView(idiomPageStyles: _idiomPageStyles);
  }
}
