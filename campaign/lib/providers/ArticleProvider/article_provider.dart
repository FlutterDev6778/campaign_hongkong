import 'dart:io';

import 'package:campaign/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class ArticleProvider extends ChangeNotifier {
  static ArticleProvider of(BuildContext context, {bool listen = false}) => Provider.of<ArticleProvider>(context, listen: listen);

  ArticleState _articleState = ArticleState.init();
  ArticleState get articleState => _articleState;

  void setArticleState(ArticleState articleState, {bool isNotifiable = true}) {
    if (_articleState != articleState) {
      _articleState = articleState;
      if (isNotifiable) notifyListeners();
    }
  }

  void getArticleData() async {
    Map<String, dynamic> articleData = await ArticleDataProvider.getArticleData();
    setArticleState(
      _articleState.update(
        articleData: articleData,
        progressState: articleData["success"] ? 2 : -1,
      ),
    );
  }
}
