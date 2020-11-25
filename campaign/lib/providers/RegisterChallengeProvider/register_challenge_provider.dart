import 'dart:io';

import 'package:campaign/DataProviders/Campaign/register_challenge_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class RegisterChallengeProvider extends ChangeNotifier {
  static RegisterChallengeProvider of(BuildContext context, {bool listen = false}) => Provider.of<RegisterChallengeProvider>(context, listen: listen);

  RegisterChallengeState _registerChallengeState = RegisterChallengeState.init();
  RegisterChallengeState get registerChallengeState => _registerChallengeState;

  void setRegisterChallengeState(RegisterChallengeState registerChallengeState, {bool isNotifiable = true}) {
    if (_registerChallengeState != registerChallengeState) {
      _registerChallengeState = registerChallengeState;
      if (isNotifiable) notifyListeners();
    }
  }

  void registerChallenge() async {
    Map<String, dynamic> registerChallengeData = await RegisterChallengeDataProvider.registerChallenge();
    setRegisterChallengeState(
      _registerChallengeState.update(
        registerChallengeData: registerChallengeData,
        progressState:
            registerChallengeData["success"] ? 2 : (registerChallengeData["msg"].toString().contains("You have already registered")) ? 2 : 0,
      ),
    );
  }
}
