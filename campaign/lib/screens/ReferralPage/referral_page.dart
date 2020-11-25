import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class ReferralPage extends StatelessWidget {
  ReferralPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReferralPageStyles _referralPageStyles = ReferralPageMobileStyles(context);

    return ReferralView(referralPageStyles: _referralPageStyles);
  }
}
