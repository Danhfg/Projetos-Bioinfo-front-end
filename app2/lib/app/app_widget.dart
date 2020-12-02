import 'package:app2/modules/signin/signin_module.dart';
import 'package:app2/shared/navigator/navigatorservice.dart';
import 'package:flutter/material.dart';

import 'package:app2/modules/predict/predict_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: SigninModule(),
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SigninModule());
          case '/predicts':
            return MaterialPageRoute(builder: (_) => PredictModule());
          default:
            return MaterialPageRoute(builder: (_) => SigninModule());
        }
      },
    );
  }
}
