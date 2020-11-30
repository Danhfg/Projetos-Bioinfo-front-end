import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/predict/predict_repository.dart';
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
