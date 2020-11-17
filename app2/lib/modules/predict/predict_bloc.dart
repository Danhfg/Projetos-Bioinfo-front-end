import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/home/home_repository.dart';
import 'package:rxdart/rxdart.dart';

class PredictBloc extends BlocBase {
  final HomeRepository homeRepository;

  PredictBloc(this.homeRepository) {
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
      var response = await homeRepository.postDecisionTree(nsSNVModel);
      yield response;
    } catch (e) {
      throw e;
    }
  }
/*
  void getDecisionTree(NsSNVModel nsSNVModel) async {
    responseIn.add(null);
    try {
      var res = await homeRepository.postDecisionTree(nsSNVModel);
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
