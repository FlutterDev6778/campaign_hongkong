import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfilePageStyles _profilePageStyles = ProfilePageMobileStyles(context);

    return ProfileView(profilePageStyles: _profilePageStyles);
  }
}
