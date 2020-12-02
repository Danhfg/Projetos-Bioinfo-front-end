import 'package:app2/app/app_module.dart';
import 'package:app2/shared/auth/auth_repository.dart';
import 'package:app2/shared/models/signinModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class AuthBloc extends BlocBase {
  String username/*= "danielhenriquefg@gmail.com"*/;
  String password/*= "teste123"*/;

  AuthBloc() {
    resultLogon = BehaviorSubject<SigninModel>();
    resultLogin = BehaviorSubject<SigninModel>();
    repo = AppModule.to.getDependency<AuthRepository>();
    responseOut = resultLogin.switchMap(loginModel);
    responseOnOut = resultLogon.switchMap(logonT);
    username = "";
    password = "";
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwt = prefs.get("jwt");
  }

  AuthRepository repo;
  String jwt;

  Future<String> login() async {
    var res = await repo.login({"username": username, "password": password});
    jwt = res /*['token']*/;
    SharedPreferences.getInstance().then(
      (value) {
        value.setString("jwt", jwt);
      },
    );
    return jwt;
  }

  var resultLogon = BehaviorSubject<SigninModel>();

  SigninModel get responseOnValue => resultLogon.value;
  Observable<int> responseOnOut;
  Sink<SigninModel> get responseOnIn => resultLogon.sink;

  Stream<int> logonT(SigninModel signinModel) async* {
    yield 0;
    try {
      var response = await repo.logon(signinModel);
      yield response.statusCode;
    } catch (e) {
      throw e;
    }
  }

  var resultLogin = BehaviorSubject<SigninModel>();

  SigninModel get responseValue => resultLogin.value;
  Observable<int> responseOut;
  Sink<SigninModel> get responseIn => resultLogin.sink;

  Stream<int> loginModel(SigninModel signinModel) async* {
    yield 0;
    try {
      var response = await repo.loginmodel(signinModel);
      jwt = response.data /*['token']*/;
      SharedPreferences.getInstance().then(
        (value) {
          value.setString("jwt", jwt);
        },
      );
      yield response.statusCode;
    } catch (e) {
      throw e;
    }
  }
}
