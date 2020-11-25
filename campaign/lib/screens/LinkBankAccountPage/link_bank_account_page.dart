import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class LinkBankAccountPage extends StatelessWidget {
  LinkBankAccountPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinkBankAccountPageStyles _linkBankAccountPageStyles = LinkBankAccountPageMobileStyles(context);

    return LinkBankAccountView(linkBankAccountPageStyles: _linkBankAccountPageStyles);
  }
}
