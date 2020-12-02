import 'package:app2/shared/constants.dart';
import 'package:app2/shared/custom_dio/intercetors.dart';
import 'package:app2/shared/models/signinModel.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Dio client;

  AuthRepository() {
    client = Dio();
    //client.options.baseUrl = BASE_URL;
    //client.interceptors.add(CustomIntercetors());
  }
  Future<String> login(Map<String, dynamic> data) async {
    try {
      var response = await client.post("http://192.168.0.46:8443/api/sign-in/",
          data: data);
      //print(response.data);
      return response.data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<Response> logon(SigninModel data) async {
    try {
      var response = await client.post(
        "http://192.168.0.46:8443/api/sign-up/",
        data: data.toMap(),
      );
      //print(response.data);
      return response;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<Response> loginmodel(SigninModel data) async {
    try {
      var response = await client.post(
        "http://192.168.0.46:8443/api/sign-in/",
        data: data.toMap(),
      );
      //print(response.data);
      return response;
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
