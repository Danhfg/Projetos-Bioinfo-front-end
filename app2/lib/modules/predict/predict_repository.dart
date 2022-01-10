import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:app2/shared/models/nsSNVGetModel.dart';
import 'package:app2/shared/models/nsSNVModel.dart';
import 'package:app2/shared/models/paginationNsSNVGETModel.dart';
import 'package:dio/dio.dart';

class PredictRepository {
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

  PredictRepository(this.dio);

  Future<int> postDecisionTree(NsSNVModel nsSNV) async {
    /*NsSNVModel nsSNV = NsSNVModel(
      chr: chr,
      pos: pos,
      ref: ref,
      alt: alt,
    );*/
    try {
      var response = await dio.client.post(
        "/api/predict/process",
        //"/posts",
        data: nsSNV.toMap(),
      );
      return (response.statusCode);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<PaginationNsSNVGETModel> getResult(
      int page, String sort, String order) async {
    try {
      var response = await dio.client.get("/api/predict/results?page=" +
          page.toString() +
          "&sort=" +
          sort +
          "," +
          order);
      return PaginationNsSNVGETModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<List<NsSNVGETModel>> getResults() async {
    try {
      var res;
      var response = await dio.client
          .get("/api/predict/results/list")
          .then((value) => {res = value});
      return (res.data as List)
          .map((item) => NsSNVGETModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      print(e.message);
      throw (e.message);
    }
  }

  Future<void> deletePrediction(int id) async {
    try {
      await dio.client.delete("/api/predict/delete/" + id.toString());
    } on DioError catch (e) {
      print(e.message);
      throw (e.message);
    }
  }
}
