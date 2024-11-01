import 'package:dio/dio.dart';
import 'package:flutter_demo/http/base_model.dart';

class RspInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      try {
        var rsp = BaseModel.fromJson(response.data);
        if (rsp.errorCode == 0) {
          if (rsp.data == null) {
            handler.next(
                Response(requestOptions: response.requestOptions, data: true));
          } else {
            handler.next(Response(
                requestOptions: response.requestOptions, data: rsp.data));
          }
        } else if (rsp.errorCode == -1001) {
          //token失效
          handler.reject(DioException(
              requestOptions: response.requestOptions, message: "未登录"));
        }
      } catch (e) {
        handler.reject(DioException(
            requestOptions: response.requestOptions, message: "$e"));
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}
