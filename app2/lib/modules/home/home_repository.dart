import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final CustomDio dio;

  /*Dio _server = Dio(
    BaseOptions(
        //connectTimeout: 5000,
        //receiveTimeout: 5000,
        baseUrl: "https://some-website.com"),
  ) ..interceptors.add(
      InterceptorsWrapper(
          
          onRequest: (RequestOptions options) => requestInterceptor(options),
          onResponse: (Response response) => responseInterceptor(response),
          onError: (DioError dioError) => errorInterceptor(dioError),
          ),
    )
      ;*/

  HomeRepository(this.dio);

  Future<int> postDecisionTree(NsSNVModel nsSNV) async {
    /*NsSNVModel nsSNV = NsSNVModel(
      chr: chr,
      pos: pos,
      ref: ref,
      alt: alt,
    );*/
    try {
      var response = await dio.client.post(
        "/api/predict/decisionTree",
        "/posts",
        data: nsSNV.toMap(),
      );
      return (response.statusCode);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<Map> login(Map<String, dynamic> data) async {
    try {
      var response = await dio.client.post("/sign_in", data: data);
      return response.data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
