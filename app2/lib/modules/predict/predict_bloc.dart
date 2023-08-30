import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/predict/predict_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PredictBloc extends BlocBase {
  final PredictRepository predictRepository;

  PredictBloc(this.predictRepository);
  /*PredictBloc(this.predictRepository) {
    offset = 0;
    totalPages = 1;
    getResults();
    order = "desc";
    sort = "idNsSNV";
  }*/

  var resultPrediction = BehaviorSubject<List<NsSNVGETModel>>();
  Sink<List<NsSNVGETModel>> get responseIn => resultPrediction.sink;
  Observable<List<NsSNVGETModel>> get responseOut => resultPrediction.stream;

  List<NsSNVGETModel> list;

  int offset;
  int totalPages;
  String sort;
  String order;

  void getResults() async {
    responseIn.add(null);
    try {
      var response = await predictRepository.getResults();
      responseIn.add(response);
    } catch (e) {
      resultPrediction.addError(e);
    }
  }

  /* getResults() async {
    // responseIn.add(null);
    try {
      if (offset < totalPages) {
        final response = await predictRepository.getResult(
            this.offset, this.sort, this.order);
        ++this.offset;
        this.list.addAll(response.content);
        totalPages = response.totalPages;
        // responseIn.add(response.content);
      }
    } catch (e) {
      return false;
    }
    return true;
  }*/

  Future<Null> getResult() async {
    try {
      if (offset < totalPages) {
        final response = await predictRepository.getResult(
            this.offset, this.sort, this.order);
        ++offset;
        totalPages = response.totalPages;
        this.list.addAll(response.content);
      }
    } catch (e) {
      throw e;
    }
  }

  Color getColor(int ndamage) {
    if (ndamage > 6) return Colors.red[400];
    if (ndamage == -1) return Colors.yellow;
    return Colors.lightGreen;
  }

  Color getColorMl(int ndamage) {
    if (ndamage >= 6) return Colors.red[400];
    if (ndamage == -1) return Colors.yellow;
    return Colors.lightGreen;
  }

  int getNdamage(String result) {
    var allPredictors = {};
    List<String> resultList = result.split("\n");
    for (String item in resultList) {
      if (item.contains("_pred:")) {
        List<String> singlePred = item.split(":");
        allPredictors[singlePred[0].toString()] = singlePred[1].split(";");
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
            allPredictors["Polyphen2_HVAR_pred"].contains("D") ||
        allPredictors["Polyphen2_HVAR_pred"].contains("P")) {
      ++nDAMAGE;
    }
    if (allPredictors["Polyphen2_HDIV_pred"] != null &&
            allPredictors["Polyphen2_HDIV_pred"].contains("D") ||
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
    if (allPredictors["MutationTaster_pred"] != null &&
            allPredictors["MutationTaster_pred"].contains("D") ||
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

    return nDAMAGE;
  }

  int getNdamageML(String resultML) {
    if (resultML == null) return -1;
    int result = 0;
    for (String i in resultML.split('\n')) {
      if (i != "") result += int.parse(i.split(':')[1]);
    }
    return result;
  }

  String getGeneName(String result) {
    if (result == null) return "";
    List<String> resultList = result.split("\n");
    for (String item in resultList) {
      if (item.contains("genename")) {
        return item.split(":")[1].split(";")[0];
      }
    }
    return "";
  }

  String processPrediction(String result) {
    if (result == null) {
      return "I";
    }
    String exacResut = "0";
    String common = "0";
    Map<String, List<String>> allPredictors = {};
    //String resultPorcess = result.replaceAll("dbNSFP_", "");
    List<String> resultList = result.split("\n");
    for (String item in resultList) {
      if (item.contains("_pred")) {
        List<String> singlePred = item.split(":");
        allPredictors[singlePred[0].toString()] = singlePred[1].split(";");
      }
      if (item.contains("ExAC_AF")) {
        exacResut = item.split(":")[1] == "." ? "0" : item.split(":")[1];
      }
      if (item.contains("1000Gp3_AF")) {
        common = item.split(":")[1] == "." ? "0" : item.split(":")[1];
      }
    }

    if (allPredictors.keys.length == 0) {
      return "I";
    }

    if ((allPredictors['SIFT_pred'].contains("T")) &&
        allPredictors['Polyphen2_HDIV_pred'].contains("B") &&
        allPredictors['PROVEAN_pred'].contains("N")) {
      return "B";
    } else {
      if (exacResut != null && double.parse(exacResut) < 0.0001) {
        return "P";
      } else {
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
        if (nDAMAGE <= 6) {
          return "B";
        } else if (common != null && double.parse(common) < 0.0001) {
          return "P";
        } else {
          return "B";
        }
      }
    }
  }

  Color getColorPred(String res) {
    if (res == "P")
      return Colors.red[400];
    else if (res == "B")
      return Colors.lightGreen;
    else
      return Colors.yellow;
  }

  String posRestricao = "";

  void delete(int id) {
    predictRepository.deletePrediction(id);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    // resultPrediction.close();
    super.dispose();
  }
}
