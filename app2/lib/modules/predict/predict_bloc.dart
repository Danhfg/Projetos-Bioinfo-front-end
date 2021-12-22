import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/predict/predict_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PredictBloc extends BlocBase {
  final PredictRepository predictRepository;

  PredictBloc(this.predictRepository) {
    offset = 0;
    totalPages = 1;
    order = "desc";
    sort = "idNsSNV";
  }

  var resultPrediction = BehaviorSubject<List<NsSNVGETModel>>();
  Sink<List<NsSNVGETModel>> get responseIn => resultPrediction.sink;
  Observable<List<NsSNVGETModel>> get responseOut => resultPrediction.stream;

  List<NsSNVGETModel> list = [];

  int offset;
  int totalPages;
  String sort;
  String order;

  void getResults() async {
    responseIn.add(null);
    try {
      if (offset < totalPages) {
        final response = await predictRepository.getResult(
            this.offset, this.sort, this.order);
        ++offset;
        totalPages = response.totalPages;
        responseIn.add(response.content);
      }
    } catch (e) {
      resultPrediction.addError(e);
    }
  }

  Future<Null> getResult() async {
    try {
      if (offset < totalPages) {
        final response = await predictRepository.getResult(
            this.offset, this.sort, this.order);
        // ++offset;
        totalPages = response.totalPages;
        this.list.addAll(response.content);
      }
    } catch (e) {
      throw e;
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
    if (allPredictors["SIFT4G_pred"] != null &&
        allPredictors["SIFT4G_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["Polyphen2_HVAR_pred"] != null &&
        allPredictors["Polyphen2_HVAR_pred"].contains("D") &&
        allPredictors["Polyphen2_HVAR_pred"].contains("P")) {
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
    if (allPredictors["MetaLR_pred"] != null &&
        allPredictors["MetaLR_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["M-CAP_pred"] != null &&
        allPredictors["M-CAP_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["PrimateAI_pred"] != null &&
        allPredictors["PrimateAI_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["DEOGEN2_pred"] != null &&
        allPredictors["DEOGEN2_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["BayesDel_addAF_pred"] != null &&
        allPredictors["BayesDel_addAF_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["BayesDel_noAF_pred"] != null &&
        allPredictors["BayesDel_noAF_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["Clinpred_pred"] != null &&
        allPredictors["Clinpred_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["LIST-S2_pred"] != null &&
        allPredictors["LIST-S2_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["Aloft_pred"] != null &&
        allPredictors["Aloft_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["fathmm-MKL_coding_pred"] != null &&
        allPredictors["fathmm-MKL_coding_pred"].contains("D")) {
      ++nDAMAGE;
    }
    if (allPredictors["fathmm-XF_coding_pred"] != null &&
        allPredictors["fathmm-XF_coding_pred"].contains("D")) {
      ++nDAMAGE;
    }

    print(result);

    return nDAMAGE;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    resultPrediction.close();
    super.dispose();
  }
}
