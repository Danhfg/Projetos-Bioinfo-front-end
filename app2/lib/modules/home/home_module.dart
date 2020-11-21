import 'package:app2/modules/home/home_repository.dart';
import 'package:app2/modules/predict/predict_bloc.dart';
import 'package:app2/modules/predict/predict_page.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:app2/shared/auth/auth_repository.dart';
import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:app2/modules/home/home_bloc.dart';
import 'package:app2/modules/home/home_page.dart';

import '../../app/app_module.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(HomeModule.to.getDependency<HomeRepository>())),
        Bloc((i) => PredictBloc(HomeModule.to.getDependency<HomeRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => HomeRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => HomePage();
  //Widget get view => PredictPage();

  static Inject get to => Inject<HomeModule>.of();
}
