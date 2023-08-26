import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class PredictClinvarBloc extends BlocBase {
  PredictClinvarBloc() {}

  Color color;

  String processClinvar(String result) {
    if (result == null || result == "") return "NF";
    List<String> clinvarResult = result.split(";");
    for (String results in clinvarResult) {
      if (results.contains("CLNSIG")) return getFinalSig(results);
    }
    return "NF";
  }

  String getFinalSig(String result) {
    if (result.toUpperCase().contains("Uncertain".toUpperCase())) {
      return "U";
    } else if (result.toUpperCase().contains("Conflicting".toUpperCase()))
      return "C";
    else if (result.toUpperCase().contains("Benign".toUpperCase())) {
      return "B";
    }
    // ;
    else if (result.toUpperCase().contains("Pathogenic".toUpperCase()))
      return "P";
    return "NF";
  }

  Color getColor(String clinvarSig) {
    if (clinvarSig.toUpperCase().contains("C")) return Colors.yellow;
    if (clinvarSig.toUpperCase().contains("B")) return Colors.lightGreen;
    if (clinvarSig.toUpperCase().contains("P")) return Colors.red[400];
    if (clinvarSig.toUpperCase().contains("U")) return Colors.orange;
    return Colors.black;
  }
}
