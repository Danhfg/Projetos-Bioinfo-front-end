import 'package:app2/shared/constants.dart';
import 'package:app2/shared/custom_dio/auth_intercetors.dart';
import 'package:app2/shared/custom_dio/intercetors.dart';
import 'package:dio/dio.dart';

class CustomDio {
  final Dio client;

  CustomDio(this.client) {
    client.options.baseUrl = BASE_URL;
    //client.interceptors.add(CustomIntercetors());
    client.interceptors.add(AuthIntercetors());
  }
}
