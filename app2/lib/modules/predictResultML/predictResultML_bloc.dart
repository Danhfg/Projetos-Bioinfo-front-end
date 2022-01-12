import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class PredictResultMLBloc extends BlocBase {
  String resultRequest;

  PredictResultMLBloc() {
    allPredictors = {};
  }

  Map<String, String> allPredictors = {};

  Color color;

  void processPrediction(String result) {
    allPredictors = {};
    //String resultPorcess = result.replaceAll("dbNSFP_", "");
    List<String> resultList = result.split("\n");
    for (String item in resultList) {
      if (item.contains(":")) {
        List<String> singlePred = item.split(":");
        allPredictors[singlePred[0].toString()] = singlePred[1];
      }
    }
  }
}
