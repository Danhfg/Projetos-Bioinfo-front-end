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
        title: Text("Solicitar Predição"),
        //centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Resultado Obtido pela árvore de decisão: ",
                    ),
                    Text(bloc.dtPrediction),
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
                /*ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 9,
                  itemBuilder: (context, index){
                  }
                ),*/
              ],
            ),
            //ListView.builder(),
          ),
        ],
      ),
    );
  }
}
