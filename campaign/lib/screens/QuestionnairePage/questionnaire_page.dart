import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/index.dart';

import 'index.dart';

class QuestionnairePage extends StatelessWidget {
  final String cohort;
  QuestionnairePage({
    Key key,
    @required this.cohort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionnairePageStyles _questionnairePageStyles = QuestionnairePageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionnaireProvider()),
        ChangeNotifierProvider(create: (_) => CompleteQuestionnaireTaskProvider()),
      ],
      child: QuestionnaireView(questionnairePageStyles: _questionnairePageStyles, cohort: cohort),
    );
  }
}
