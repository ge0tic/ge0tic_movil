import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';

class BaseProvider {
  Future baseProvider(String urlEndpoint, Map<String, dynamic> paramsBody,
      Map<String, String> paramsHeader, String met) async {
    late Response _res;
    Dio dio = Dio(BaseOptions(
        baseUrl: Constantes.urlRestApi,
        receiveDataWhenStatusError: true,
        connectTimeout: 10 * 1000, // 10 seconds
        receiveTimeout: 10 * 1000, // 10 seconds
        method: met,
        headers: paramsHeader));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      _res = await dio.request(
        urlEndpoint,
        data: paramsBody,
      );
      return _res.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        Utils.showSnakbarError(
            "No hay conexión al servidor", "Por favor intente más tarde", 3);
      }
      //return _res.data;
    }
  }
}
