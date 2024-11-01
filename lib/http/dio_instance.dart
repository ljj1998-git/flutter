import 'package:dio/dio.dart';
import 'package:flutter_demo/http/http_method.dart';
import 'package:flutter_demo/http/print_log_interceptor.dart';
import 'package:flutter_demo/http/rsp_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  // 静态私有的构造方法
  DioInstance._();

  static DioInstance instance() {
    // 为null则创建实例,否则直接返回实例
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTime = const Duration(seconds: 30);
  void initDio({
    String? httpMethod = HttpMethod.GET,
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
        method: httpMethod,
        baseUrl: baseUrl,
        connectTimeout: connectTimeout ?? _defaultTime,
        receiveTimeout: receiveTimeout ?? _defaultTime,
        sendTimeout: sendTimeout ?? _defaultTime,
        responseType: responseType,
        contentType: contentType);
    // 添加打印请求返回值拦截器
    _dio.interceptors.add(PrintLogInterceptor());
    // 添加统一返回处理拦截器
    _dio.interceptors.add(RspInterceptor());
  }

  // get请求
  Future<Response> get({
    required String path,
    Map<String, dynamic>? parmas,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(path,
        queryParameters: parmas,
        options: options ??
            Options(
                method: HttpMethod.GET,
                receiveTimeout: _defaultTime,
                sendTimeout: _defaultTime),
        cancelToken: cancelToken);
  }

  // post请求
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
                method: HttpMethod.POST,
                receiveTimeout: _defaultTime,
                sendTimeout: _defaultTime),
        cancelToken: cancelToken);
  }
}
