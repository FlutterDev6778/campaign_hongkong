import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class TempPage extends StatelessWidget {
  final String title;

  TempPage({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TempPageStyles _tempPageStyles = TempPageMobileStyles(context);

    return TempView(tempPageStyles: _tempPageStyles, title: title);
  }
}
