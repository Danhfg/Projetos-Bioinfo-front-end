import 'package:app2/modules/predict/components/menuBar_repository.dart';
import 'package:app2/shared/models/signinModel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class MenuBarBloc extends BlocBase {
  SigninModel user;

  MenuBarBloc(this.repo);

  MenuBarRepository repo;

  void getUser() async {
    try {
      this.user = await repo.getUserData();
    } catch (e) {
      throw (e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
