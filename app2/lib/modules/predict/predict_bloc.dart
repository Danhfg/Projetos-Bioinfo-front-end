import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/predict/predict_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PredictBloc extends BlocBase {
  final PredictRepository predictRepository;

  String email;

  String password;

  PredictBloc(this.predictRepository);

  var resultPrediction = BehaviorSubject<List<NsSNVGETModel>>();
  Sink<List<NsSNVGETModel>> get responseIn => resultPrediction.sink;
  Observable<List<NsSNVGETModel>> get responseOut => resultPrediction.stream;
/*
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwt = prefs.get("jwt");
  }
*/

  String jwt;
/*
  Future<String> login() async {
    var res = await predictRepository.login(
        {"username": "danielhenriquefg@gmail.com", "password": "teste123"});
    print(res);
    jwt = res /*['token']*/;
    SharedPreferences.getInstance().then((value) {
      value.setString("jwt", jwt);
    });
    return jwt;
  }
*/
  void getResults() async {
    responseIn.add(null);
    try {
      var response = await predictRepository.getResult();
      print(response);
      responseIn.add(response);
    } catch (e) {
      resultPrediction.addError(e);
    }
  }

  Color getColor(int ndamage) {
    if (ndamage > 6) return Colors.red[400];
    return Colors.lightGreen;
  }

  int getNdamage(String result) {
    var allPredictors = {};
    List<String> resultList =
        result.split("\t")[7].replaceAll("dbNSFP_", "").split(";");
    print(result);
    for (String item in resultList) {
      if (item.contains("_pred=")) {
        List<String> singlePred = item.split("=");
        allPredictors[singlePred[0].toString()] = singlePred[1].split(",");
      }
    }

    int nDAMAGE = 0;
    if (allPredictors["SIFT_pred"] != null &&
        allPredictors["SIFT_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["Polyphen2_HDIV_pred"] != null &&
        allPredictors["Polyphen2_HDIV_pred"].contains("D") &&
        allPredictors["Polyphen2_HDIV_pred"].contains("P")) {
      ++nDAMAGE;
    }
    if (allPredictors["PROVEAN_pred"] != null &&
        allPredictors["PROVEAN_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["LRT_pred"] != null &&
        allPredictors["LRT_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["MetaSVM_pred"] != null &&
        allPredictors["MetaSVM_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["FATHMM_pred"] != null &&
        allPredictors["FATHMM_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["MutationAssessor_pred"] != null &&
        (allPredictors["MutationAssessor_pred"].contains("H") ||
            allPredictors["MutationAssessor_pred"].contains("M"))) {
      ++nDAMAGE;
    }
    if (allPredictors["Polyphen2_HVAR_pred"] != null &&
        allPredictors["Polyphen2_HVAR_pred"].contains("D") &&
        allPredictors["Polyphen2_HVAR_pred"].contains("P")) {
      ++nDAMAGE;
    }
    if (allPredictors["MutationTaster_pred"] != null &&
        allPredictors["MutationTaster_pred"].contains("D") &&
        allPredictors["MutationTaster_pred"].contains("A")) {
      ++nDAMAGE;
    }

    print(result);

    return nDAMAGE;
  }

/*
  void postDecisionTree(NsSNVModel nsSNVModel) async {
    try {
      var res = await predictRepository.postDecisionTree(nsSNVModel);
      responseIn.add(res);
    } catch (e) {
      resultPrediction.addError(e);
    }
  }
*/
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    resultPrediction.close();
    super.dispose();
  }
}
