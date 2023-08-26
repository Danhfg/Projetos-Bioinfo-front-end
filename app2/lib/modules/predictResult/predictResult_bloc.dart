import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class PredictResultBloc extends BlocBase {
  String resultRequest;

  PredictResultBloc() {
    allPredictors = {};
    dtPrediction = "";
    exacResut = null;
  }

  Map<String, List<String>> allPredictors = {};

  String dtPrediction;

  Color color;

  String exacResut;

  String common;

  /*final Map<String, Map<String, String>> resultPTbyPred = {
    "SIFT4G_pred": {"D": "Patogênica", "T": "Neutra"},
    "SIFT4G_pred": {"D": "Patogênica", "T": "Neutra"},
    "Polyphen2_HDIV_pred": {"D": "Patogênica", "B": "Neutra", "P": "Neutra"},
    "Polyphen2_HVAR_pred": {"D": "Patogênica", "B": "Neutra", "P": "Neutra"},
    "LRT_pred": {"D": "Patogênica", "N": "Neutra", "U": "Neutra"},
    "MutationTaster_pred": {
      "A": "Patogênica",
      "D": "Patogênica",
      "N": "Neutra",
      "P": "Neutra"
    },
    "MutationAssessor_pred": {
      "H": "Patogênica",
      "M": "Patogênica",
      "L": "Neutra",
      "N": "Neutra"
    },
    "FATHMM_pred": {"D": "Patogênica", "T": "Neutra"},
    "PROVEAN_pred": {"D": "Patogênica", "N": "Neutra"},
    "MetaSVM_pred": {"D": "Patogênica", "T": "Neutra"},
    "MetaLR_pred": {"D": "Patogênica", "T": "Neutra"},
    "M-CAP_pred": {"D": "Patogênica", "T": "Neutra"},
    "PrimateAI_pred": {"D": "Patogênica", "T": "Neutra"},
    "DEOGEN2_pred": {"D": "Patogênica", "T": "Neutra"},
    "BayesDel_addAF_pred": {"D": "Patogênica", "T": "Neutra"},
    "BayesDel_noAF_pred": {"D": "Patogênica", "T": "Neutra"},
    "ClinPred_pred": {"D": "Patogênica", "T": "Neutra"},
    "List-S2_pred": {"D": "Patogênica", "T": "Neutra"},
    "Aloft_pred": {
      "Recessive": "Patogênica",
      "Tolerant": "Neutra",
      "Dominant": "Patogênica",
    },
    "FATHMM_pred": {"D": "Patogênica", "N": "Neutra"},
    /*"fathmm-XF_coding_pred": {"D": "Patogênica", "N": "Neutra"},*/
    "Gene_indispensability_pred": {"N": "Patogênica", "E": "Neutra"},
  };
*/
  void processPrediction(String result) {
    exacResut = "0";
    common = "0";
    allPredictors = {};
    //String resultPorcess = result.replaceAll("dbNSFP_", "");
    List<String> resultList = result.split("\n");
    for (String item in resultList) {
      if (item.contains("_pred")) {
        List<String> singlePred = item.split(":");
        allPredictors[singlePred[0].toString()] = singlePred[1].split(";");
      }
      if (item.contains("ExAC_AF")) {
        exacResut = item.split(":")[1] == "." ? "0" : item.split(":")[1];
        allPredictors["ExAC_AF"] = [exacResut];
      }
      if (item.contains("1000Gp3_AF")) {
        common = item.split(":")[1] == "." ? "0" : item.split(":")[1];
        allPredictors["1000Gp3_AF"] = [common];
      }
    }

    if (!(allPredictors['SIFT_pred'].contains("D")) &&
        !(allPredictors['Polyphen2_HDIV_pred'].contains("D") ||
            allPredictors["Polyphen2_HDIV_pred"].contains("P")) &&
        !(allPredictors['PROVEAN_pred'].contains("D"))) {
      dtPrediction = "Neutra";
      color = Colors.lightGreen;
    } else {
      if (exacResut != null && double.parse(exacResut) < 0.0001) {
        dtPrediction = "Patogênica";
        color = Colors.red;
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
        if (nDAMAGE <= 6) {
          dtPrediction = "Neutra";
          color = Colors.lightGreen;
        } else if (common != null && double.parse(common) < 0.0001) {
          dtPrediction = "Patogênica";
          color = Colors.red;
        } else {
          dtPrediction = "Neutra";
          color = Colors.lightGreen;
        }
      }
    }

    if (allPredictors.keys.length == 0) {
      dtPrediction = "Quantidade de preditores insuficiente!";
      color = Colors.black;
    }
  }
}
