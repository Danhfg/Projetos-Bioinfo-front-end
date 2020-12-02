import 'package:app2/app/app_bloc.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:app2/shared/auth/auth_repository.dart';
import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app2/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
        Bloc((i) => new AuthBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => Dio()),
        Dependency((i) => CustomDio(i.getDependency<Dio>())),
        Dependency((i) => AuthRepository()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
