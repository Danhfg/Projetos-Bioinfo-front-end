import 'package:app2/modules/predictResult/predictResult_bloc.dart';
import 'package:app2/modules/signin/signin_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:app2/modules/predict/predict_bloc.dart';
import 'package:app2/modules/predict/predict_page.dart';
import 'package:app2/modules/predict/predict_repository.dart';
import 'package:app2/modules/predictRequest/predictRequest_bloc.dart';
import 'package:app2/modules/predictRequest/predictRequest_page.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:app2/shared/auth/auth_repository.dart';
import 'package:app2/shared/custom_dio/curstom_dio.dart';

import '../../app/app_module.dart';

class PredictModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => PredictBloc(
            PredictModule.to.getDependency<PredictRepository>(),
          ),
        ),
        Bloc(
          (i) => new PredictRequestBloc(
            PredictModule.to.getDependency<PredictRepository>(),
          ),
        ),
        Bloc(
          (i) => new PredictResultBloc(),
        ),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => PredictRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => PredictPage();
  //Widget get view => SignInPage();

  static Inject get to => Inject<PredictModule>.of();
}
