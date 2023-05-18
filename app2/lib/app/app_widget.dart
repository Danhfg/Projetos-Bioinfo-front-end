import 'package:app2/modules/signin/signin_module.dart';
import 'package:app2/modules/signup/signup_page.dart';
import 'package:app2/shared/constants.dart';
import 'package:app2/shared/navigator/navigatorservice.dart';
import 'package:flutter/material.dart';

import 'package:app2/modules/predict/predict_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dtree Pred',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: SigninModule(),
      navigatorKey: NavigationService.navigationKey,
      initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => const SigninModule(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/predicts': (context) => const SecondScreen(),
      // },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SigninModule());
          case '/predicts':
            return MaterialPageRoute(builder: (_) => PredictModule());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignupPage());
          default:
            return MaterialPageRoute(builder: (_) => SigninModule());
        }
      },
    );
  }
}
