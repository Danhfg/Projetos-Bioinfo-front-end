import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:app2/shared/custom_dio/intercetors.dart';
import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final CustomDio dio;
  final Dio dio2 = Dio();

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
        "http://192.168.0.46:8443/api/predict/decisionTree",
        //"/posts",
        data: nsSNV.toMap(),
      );
      return (response.statusCode);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<List<NsSNVGETModel>> getResult() async {
    try {
      print("AAAAAAAAAAAAAAAA");
      var res;
      var response = await dio.client
          .get("http://192.168.0.46:8443/api/predict/result")
          .then((value) => {print(value), res = value});
      //print("BBBBBBBBBBB");
      //print(res.data);
      return (res.data as List)
          .map((item) => NsSNVGETModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      print("CCCCCCCCCCCCC");
      throw (e.message);
    }
  }
/*
  Future<String> login(Map<String, dynamic> data) async {
    try {
      //dio2.interceptors.add(CustomIntercetors());
      var response1 = await dio2.post(
        "http://192.168.0.46:8443/api/sign-in/",
        data: data,
      );
      print(response1.data);
      var response = await dio.client.post(
        "http://192.168.0.46:8443/api/sign-in/",
        data: data,
      );
      /*var response = await dio.client
          .post("/api/sign-in/", data: data);
      print("BBBBBBBBBBBBBBBBB");*/
      return response1.data;
    } on DioError catch (e) {
      print("AAAAAAAAAAAAAAAAA");
      throw (e.message);
    }
  }*/
}
