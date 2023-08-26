import 'dart:io';

import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/predict/predict_repository.dart';
import 'package:rxdart/rxdart.dart';

class PredictRequestBloc extends BlocBase {
  final PredictRepository predictRepository;

  File vcfFile;

  String vcfName = "No vcf selected";

  PredictRequestBloc(this.predictRepository) {
    responseOut = resultPrediction.switchMap(postDecisionTree);
  }
  reset() {
    resultPrediction = BehaviorSubject<NsSNVModel>();
    responseOut = resultPrediction.switchMap(postDecisionTree);
  }

  String chr;
  int pos;
  String ref;
  String alt;

  var resultPrediction = BehaviorSubject<NsSNVModel>();

  NsSNVModel get responseValue => resultPrediction.value;
  Observable<int> responseOut;
  Sink<NsSNVModel> get responseIn => resultPrediction.sink;

  Stream<int> postDecisionTree(NsSNVModel nsSNVModel) async* {
    yield 0;
    try {
      var response = await predictRepository.postDecisionTree(nsSNVModel);
      yield response;
    } catch (e) {
      throw e;
    }
  }
/*
  void getDecisionTree(NsSNVModel nsSNVModel) async {
    responseIn.add(null);
    try {
      var res = await predictRepository.postDecisionTree(nsSNVModel);
      responseIn.add(res);
    } catch (e) {
      resultPrediction.addError(e);
    }
  }

  void getAllPrediction(NsSNVModel nsSNVModel) async {}*/

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
