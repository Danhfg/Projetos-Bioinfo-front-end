import 'package:app2/app/app_module.dart';
import 'package:app2/shared/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class AuthBloc extends BlocBase {
  String username = "danielhenriquefg@gmail.com";
  String password = "teste123";

  AuthBloc() {
    repo = AppModule.to.getDependency<AuthRepository>();
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
}
