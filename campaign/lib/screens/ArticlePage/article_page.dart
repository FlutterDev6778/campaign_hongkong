import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/index.dart';

import 'index.dart';

class ArticlePage extends StatelessWidget {
  final String cohort;

  ArticlePage({
    Key key,
    @required this.cohort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticlePageStyles _articlePageStyles = ArticlePageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => CompleteArticleTaskProvider()),
      ],
      child: ArticleView(articlePageStyles: _articlePageStyles, cohort: cohort),
    );
  }
}
