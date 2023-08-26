import 'package:app2/modules/predict/predict_module.dart';
import 'package:app2/modules/predictResultML/predictResultML_bloc.dart';
import 'package:flutter/material.dart';

class PredictClinvarPage extends StatefulWidget {
  @override
  _PredictResultPageMLState createState() => _PredictResultPageMLState();
}

class _PredictResultPageMLState extends State<PredictClinvarPage> {
  var bloc = PredictModule.to.getBloc<PredictResultMLBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Linear Discriminant Analysis:"),
              // subtitle: Text(
              //   (() {
              //     if (bloc.allPredictors['LinearDiscriminantAnalysis']
              //         .contains("1")) {
              //       return "Pathogenic Mutation";
              //     }
              //     return "Benign Mutation";
              //   })(),
              //   style: TextStyle(
              //       color: (bloc.allPredictors['LinearDiscriminantAnalysis']
              //               .contains("1"))
              //           ? Colors.red
              //           : Colors.lightGreen),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
