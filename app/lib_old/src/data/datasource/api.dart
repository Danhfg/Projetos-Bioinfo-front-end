import 'dart:convert';

import 'package:app/src/data/models/nsSNVModel.dart';
import 'package:app/src/domain/entities/nsSNV.dart';
import 'package:dio/dio.dart';

class Api {
  final Dio dio = Dio();

  decisionTree(String chr, int pos, String ref, String alt) async {
    NsSNVModel nsSNV = NsSNVModel(
      chr: chr,
      pos: pos,
      ref: ref,
      alt: alt,
    );
    final response = await dio.get(
      "http://192.168.0.46:8443/api/predict/decisionTree",
      queryParameters: nsSNV.toMap(),
    );
    if (response.statusCode == 200)
      return response.data;
    else
      return "API Error";
  }

  allPretictiors(String chr, int pos, String ref, String alt) async {
    NsSNVModel nsSNV = NsSNVModel(
      chr: chr,
      pos: pos,
      ref: ref,
      alt: alt,
    );

    Response response = await dio.get(
      "http://192.168.0.46:8443/api/predict/allPretictiors",
      queryParameters: nsSNV.toMap(),
    );
    return response.data;
  }
}
