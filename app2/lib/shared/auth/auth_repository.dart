import 'package:app2/shared/constants.dart';
import 'package:app2/shared/custom_dio/intercetors.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Dio _client;

  AuthRepository() {
    _client = Dio();
    _client.options.baseUrl = BASE_URL;
    _client.interceptors.add(CustomIntercetors());
  }
  Future<Map> login(Map<String, dynamic> data) async {
    try {
      var response = await _client.post("/sign_in", data: data);
      return response.data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
