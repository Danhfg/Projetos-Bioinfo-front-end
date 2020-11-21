import 'package:app2/app/app_module.dart';
import 'package:app2/shared/auth/auth_bloc.dart';
import 'package:app2/shared/custom_dio/curstom_dio.dart';
import 'package:dio/dio.dart';

class AuthIntercetors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    AuthBloc auth = AppModule.to.getBloc<AuthBloc>();
    CustomDio dio = AppModule.to.getDependency<CustomDio>();
    await auth.getToken();
    var jwt = auth.jwt;
    print(jwt);

    if (jwt == null) {
      dio.client.lock();

      jwt = await auth.login();
      print(jwt);
      options.headers.addAll({"Authorization": jwt});

      dio.client.unlock();

      return options;
    } else {
      options.headers.addAll({"Authorization": jwt});
      return options;
    }
  }

  /*@override
  onResponse(Response response) {
    print("RESPONSE[${response.statusCode}] => PATH: ${response.request.path}");
    print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
    return response.data;
  }*/

  @override
  onError(DioError error) {
    //Exception
    print(
        "ERROR[${error.response?.statusCode}] => PATH: ${error.request.path}");
    print(error);

    if (error.response?.statusCode == 500) {
      CustomDio dio = AppModule.to.getDependency<CustomDio>();
      AuthBloc auth = AppModule.to.getBloc<AuthBloc>();

      RequestOptions options = error.response.request;

      if (auth.jwt != options.headers["Authorization"]) {
        options.headers["Authorization"] = auth.jwt;
        return dio.client.request(options.path, options: options);
      }

      dio.client.lock();
      dio.client.interceptors.responseLock.lock();
      dio.client.interceptors.errorLock.lock();

      return auth.login().then((d) {
        //update csrfToken
        options.headers["Authorization"] = d;
      }).whenComplete(() {
        dio.client.unlock();
        dio.client.interceptors.responseLock.unlock();
        dio.client.interceptors.errorLock.unlock();
      }).then((e) {
        //repeat
        return dio.client.request(options.path, options: options);
      });
    }
  }
}
