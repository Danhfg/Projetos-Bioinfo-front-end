import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:app2/modules/home/home_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends BlocBase {
  final HomeRepository homeRepository;

  String email;

  String password;

  HomeBloc(this.homeRepository);

  var resultPrediction = BehaviorSubject<String>();
  Sink<String> get responseIn => resultPrediction.sink;
  Observable<String> get responseOut => resultPrediction.stream;

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwt = prefs.get("jwt");
  }

  String jwt;

  Future<String> login() async {
    var res =
        await homeRepository.login({"email": email, "password": password});
    jwt = res['token'];
    SharedPreferences.getInstance().then((value) {
      value.setString("jwt", jwt);
    });
    return jwt;
  }

/*
  void postDecisionTree(NsSNVModel nsSNVModel) async {
    try {
      var res = await homeRepository.postDecisionTree(nsSNVModel);
      responseIn.add(res);
    } catch (e) {
      resultPrediction.addError(e);
    }
  }
*/
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
