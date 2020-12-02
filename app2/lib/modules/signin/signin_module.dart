import 'package:app2/modules/signin/signin_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class SigninModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  //Widget get view => PredictPage();
  Widget get view => SignInPage();

  static Inject get to => Inject<SigninModule>.of();
}
