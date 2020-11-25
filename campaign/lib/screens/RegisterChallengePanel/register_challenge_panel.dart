import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class RegisterChallengePanel {
  static KumiPopupWindow popupWindow;

  void hide(BuildContext context) {
    popupWindow.dismiss(context);
  }

  void show(BuildContext context, Map<String, dynamic> campaignData) {
    RegisterChallengePanelStyles _registerChallengePanelStyles = RegisterChallengePanelMobileStyles(context);

    popupWindow = createPopupWindow(
      context,
      gravity: KumiPopupGravity.center,
      bgColor: Colors.black.withAlpha(200),
      clickOutDismiss: false,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      underStatusBar: false,
      underAppBar: false,
      offsetX: 0,
      offsetY: 0,
      duration: Duration(milliseconds: 200),
      onShowStart: (pop) {},
      onShowFinish: (pop) {},
      onDismissStart: (pop) {
        print("onDismissStart");
      },
      onDismissFinish: (pop) {
        print("onDismissFinish");
      },
      onClickOut: (pop) {
        print("onClickOut");
        return null;
      },
      onClickBack: (pop) {
        print("onClickOut");
      },
      childFun: (controller) {
        return RegisterChallengeView(
          key: GlobalKey(),
          registerChallengePanelStyles: _registerChallengePanelStyles,
          campaignData: campaignData,
        );
      },
    );
    popupWindow.show(context);
  }
}
