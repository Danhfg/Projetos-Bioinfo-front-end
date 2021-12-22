import 'package:app2/shared/constants.dart';
import 'package:app2/shared/models/signinModel.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Dio client;

  AuthRepository() {
    client = Dio();
    client.options.baseUrl = BASE_URL;
    //client.interceptors.add(CustomIntercetors());
  }
  Future<String> login(Map<String, dynamic> data) async {
    try {
      var response = await client.post(BASE_URL + "/api/sign-in/", data: data);
      //print(response.data);
      return response.data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<Response> logon(SigninModel data) async {
    try {
      var response = await client.post(
        "/api/sign-up/",
        data: data.toMap(),
      );
      return response;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<Response> loginmodel(SigninModel data) async {
    try {
      var response = await client.post(
        "/api/sign-in/",
        data: data.toMap(),
      );
      return response;
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
