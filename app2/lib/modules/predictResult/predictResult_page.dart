import 'package:app2/modules/predict/predict_module.dart';
import 'package:app2/modules/predictResult/predictResult_bloc.dart';
import 'package:flutter/material.dart';

class PredictResultPage extends StatefulWidget {
  @override
  _PredictResultPageState createState() => _PredictResultPageState();
}

class _PredictResultPageState extends State<PredictResultPage> {
  var bloc = PredictModule.to.getBloc<PredictResultBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Resultado Obtido pela árvore de decisão:  "),
              subtitle: Text(
                (() {
                  if (bloc.allPredictors.keys.length == 0) {
                    return bloc.dtPrediction;
                  }
                  return "Mutação " + bloc.dtPrediction;
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors.keys.length == 0)
                        ? Colors.black
                        : (bloc.dtPrediction == "Patogênica")
                            ? Colors.red
                            : Colors.lightGreen),
              ),
              /*Text(
                "Mutação " + bloc.dtPrediction,
                style: TextStyle(color: bloc.color),
              ),*/
              trailing: Tooltip(
                message:
                    "do Nascimento, Priscilla Machado et al. “A decision tree to improve identification of pathogenic mutations in clinical practice.” BMC medical informatics and decision making vol. 20,1 52. 10 Mar. 2020, doi:10.1186/s12911-020-1060-0",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: bloc.color,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor MetaSVM:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['MetaSVM_pred'].toString());
                  if (bloc.allPredictors['MetaSVM_pred'] != null &&
                      bloc.allPredictors['MetaSVM_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['MetaSVM_pred'] == null) {
                    return "Sem predição";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                  color: (bloc.allPredictors['MetaSVM_pred'] != null &&
                          bloc.allPredictors['MetaSVM_pred'].contains("D"))
                      ? Colors.red
                      : (bloc.allPredictors['MetaSVM_pred'] != null)
                          ? Colors.lightGreen
                          : Colors.black,
                ),
              ),
              /*Text(
                    "MetaSVM: " + bloc.allPredictors['MetaSVM_pred'].toString(),
                    style: TextStyle(
                        color: bloc.allPredictors['MetaSVM_pred'].contains("D")
                            ? Colors.red
                            : Colors.lightGreen),
                  ),*/
              trailing: Tooltip(
                message: "https://github.com/jjh0925/metaSVM",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor FATHMM:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['FATHMM_pred'].toString());
                  if (bloc.allPredictors['FATHMM_pred'] != null &&
                      bloc.allPredictors['FATHMM_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['FATHMM_pred'] == null) {
                    return "Sem predição";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['FATHMM_pred'] != null &&
                            bloc.allPredictors['FATHMM_pred'].contains("D"))
                        ? Colors.red
                        : (bloc.allPredictors['FATHMM_pred'] != null)
                            ? Colors.lightGreen
                            : Colors.black),
              ),
              trailing: Tooltip(
                message: "fathmm.biocompute.org.uk",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor LRT:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['LRT_pred'].toString());
                  if (bloc.allPredictors['LRT_pred'] != null &&
                      bloc.allPredictors['LRT_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['LRT_pred'] == null) {
                    return "Sem predição";
                  }
                  if (bloc.allPredictors['LRT_pred'].contains("U")) {
                    return "Mudação desconhecida";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['LRT_pred'] != null &&
                            bloc.allPredictors['LRT_pred'].contains("D"))
                        ? Colors.red
                        : (bloc.allPredictors['LRT_pred'] == null)
                            ? Colors.black
                            : (bloc.allPredictors['LRT_pred'].contains("U"))
                                ? Colors.yellow
                                : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "www.genetics.wustl.edu/jflab/lrt_query.html",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor PROVEAN:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['PROVEAN_pred'].toString());
                  if (bloc.allPredictors['PROVEAN_pred'] != null &&
                      bloc.allPredictors['PROVEAN_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['PROVEAN_pred'] == null) {
                    return "Sem predição";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['PROVEAN_pred'] != null &&
                            bloc.allPredictors['PROVEAN_pred'].contains("D"))
                        ? Colors.red
                        : (bloc.allPredictors['PROVEAN_pred'] == null)
                            ? Colors.black
                            : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "provean.jcvi.org/index.php",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor Polyphen2_HDIV:  "),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['Polyphen2_HDIV_pred'].toString());
                  if (bloc.allPredictors['Polyphen2_HDIV_pred'] != null &&
                      bloc.allPredictors['Polyphen2_HDIV_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['Polyphen2_HDIV_pred'] == null) {
                    return "Sem predição";
                  }
                  if (bloc.allPredictors['Polyphen2_HDIV_pred'].contains("P")) {
                    return "Mudação possívelmente Patogênica";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['Polyphen2_HDIV_pred'] != null &&
                            bloc.allPredictors['Polyphen2_HDIV_pred']
                                .contains("D"))
                        ? Colors.red
                        : (bloc.allPredictors['Polyphen2_HDIV_pred'] == null)
                            ? Colors.black
                            : (bloc.allPredictors['Polyphen2_HDIV_pred']
                                    .contains("P"))
                                ? Colors.yellow
                                : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "http://genetics.bwh.harvard.edu/pph2/",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor MutationTaster:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['MutationTaster_pred'].toString());
                  if (bloc.allPredictors['MutationTaster_pred'] != null &&
                      bloc.allPredictors['MutationTaster_pred'].contains("A")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['MutationTaster_pred'] == null) {
                    return "Sem predição";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['MutationTaster_pred'] != null &&
                            bloc.allPredictors['MutationTaster_pred']
                                .contains("A"))
                        ? Colors.red
                        : (bloc.allPredictors['MutationTaster_pred'] == null)
                            ? Colors.black
                            : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "www.mutationtaster.org/",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor MutationAssessor:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['MutationAssessor_pred'].toString());
                  if (bloc.allPredictors['MutationAssessor_pred'] != null &&
                      bloc.allPredictors['MutationAssessor_pred']
                          .contains("H")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['MutationAssessor_pred'] == null) {
                    return "Sem predição";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['MutationAssessor_pred'] !=
                                null &&
                            bloc.allPredictors['MutationAssessor_pred']
                                .contains("H"))
                        ? Colors.red
                        : (bloc.allPredictors['MutationAssessor_pred'] == null)
                            ? Colors.black
                            : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "mutationassessor.org/",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor Polyphen2_HVAR:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['Polyphen2_HVAR_pred'].toString());
                  if (bloc.allPredictors['Polyphen2_HVAR_pred'] != null &&
                      bloc.allPredictors['Polyphen2_HVAR_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['Polyphen2_HVAR_pred'] == null) {
                    return "Sem predição";
                  }
                  if (bloc.allPredictors['Polyphen2_HVAR_pred'].contains("P")) {
                    return "Mudação possívelmente Patogênica";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['Polyphen2_HVAR_pred'] != null &&
                            bloc.allPredictors['Polyphen2_HVAR_pred']
                                .contains("D"))
                        ? Colors.red
                        : (bloc.allPredictors['Polyphen2_HVAR_pred'] == null)
                            ? Colors.black
                            : (bloc.allPredictors['Polyphen2_HVAR_pred']
                                    .contains("P"))
                                ? Colors.yellow
                                : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "http://genetics.bwh.harvard.edu/pph2/",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Preditor SIFT:"),
              subtitle: Text(
                (() {
                  print(bloc.allPredictors['SIFT_pred'].toString());
                  if (bloc.allPredictors['SIFT_pred'] != null &&
                      bloc.allPredictors['SIFT_pred'].contains("D")) {
                    return "Mutação Patogênica";
                  }
                  if (bloc.allPredictors['SIFT_pred'] == null) {
                    return "Sem predição";
                  }

                  return "Mutação Neutra";
                })(),
                style: TextStyle(
                    color: (bloc.allPredictors['SIFT_pred'] != null &&
                            bloc.allPredictors['SIFT_pred'].contains("D"))
                        ? Colors.red
                        : (bloc.allPredictors['SIFT_pred'] == null)
                            ? Colors.black
                            : Colors.lightGreen),
              ),
              trailing: Tooltip(
                message: "sift.bii.a-star.edu.sg/",
                child: new IconButton(
                  icon: new Icon(
                    Icons.help,
                    //color: Colors.lightGreen,
                  ),
                ),
              ),
            ),

            /*Row(
                  children: <Widget>[
                    Text(
                      "Resultado Obtido pela árvore de decisão: ",
                    ),
                    Text("Mutação " + bloc.dtPrediction),
                    Tooltip(
                      message:
                          "do Nascimento, Priscilla Machado et al. “A decision tree to improve identification of pathogenic mutations in clinical practice.” BMC medical informatics and decision making vol. 20,1 52. 10 Mar. 2020, doi:10.1186/s12911-020-1060-0",
                      child: CircleAvatar(
                        child: Text(
                          "?",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.black12,
                        radius: 12,
                      ),
                    ),
                  ],
                ),
                ListBody(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "MetaSVM: " +
                          bloc.allPredictors['MetaSVM_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "FATHMM: " + bloc.allPredictors['FATHMM_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "LRT: " + bloc.allPredictors['LRT_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PROVEAN: " +
                          bloc.allPredictors['PROVEAN_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Polyphen2_HDIV: " +
                          bloc.allPredictors['Polyphen2_HDIV_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "MutationTaster: " +
                          bloc.allPredictors['MutationTaster_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "MutationAssessor: " +
                          bloc.allPredictors['MutationAssessor_pred']
                              .toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Polyphen2_HVAR: " +
                          bloc.allPredictors['Polyphen2_HVAR_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "SIFT: " + bloc.allPredictors['SIFT_pred'].toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                */
          ],
        ),
      ),
    );
  }
}
