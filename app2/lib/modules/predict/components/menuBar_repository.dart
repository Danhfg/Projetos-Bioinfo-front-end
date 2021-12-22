import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:app2/shared/models/signinModel.dart';
import 'package:dio/dio.dart';

class MenuBarRepository {
  CustomDio dio;

  MenuBarRepository(this.dio);

  Future<SigninModel> getUserData() async {
    try {
      var response = await dio.client.get(
        "/api/user",
      );
      return (SigninModel.fromMap(response.data));
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
