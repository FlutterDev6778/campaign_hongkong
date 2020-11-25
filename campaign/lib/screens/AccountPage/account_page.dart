import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountPageStyles _accountPageStyles = AccountPageMobileStyles(context);

    return AccountView(accountPageStyles: _accountPageStyles);
  }
}
