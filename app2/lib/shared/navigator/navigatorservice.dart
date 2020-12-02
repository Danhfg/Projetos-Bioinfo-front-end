import 'package:flutter/material.dart';

final NavigationService navService = NavigationService();

class NavigationService<T, U> {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<T> pushNamed(String routeName, {Object args}) async =>
      navigationKey.currentState.pushNamed<T>(
        routeName,
        arguments: args,
      );

  Future<T> push(Route<T> route) async =>
      navigationKey.currentState.push<T>(route);

  Future<T> pushReplacementNamed(String routeName, {Object args}) async =>
      navigationKey.currentState.pushReplacementNamed<T, U>(
        routeName,
        arguments: args,
      );

  Future<T> pushNamedAndRemoveUntil(
    String routeName, {
    Object args,
    bool keepPreviousPages = false,
  }) async =>
      navigationKey.currentState.pushNamedAndRemoveUntil<T>(
        routeName,
        (Route<dynamic> route) => keepPreviousPages,
        arguments: args,
      );

  Future<T> pushAndRemoveUntil(
    Route<T> route, {
    bool keepPreviousPages = false,
  }) async =>
      navigationKey.currentState.pushAndRemoveUntil<T>(
        route,
        (Route<dynamic> route) => keepPreviousPages,
      );

  Future<bool> maybePop([Object args]) async =>
      navigationKey.currentState.maybePop<bool>(args);

  bool canPop() => navigationKey.currentState.canPop();

  void goBack({T result}) => navigationKey.currentState.pop<T>(result);
}
