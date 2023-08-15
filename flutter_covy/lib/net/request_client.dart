import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_covy/model/article_list_entity.dart';
import 'package:flutter_covy/model/base_entity.dart';
import 'package:flutter_covy/model/public_account.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/Project_list_entity.dart';
import '../model/banner_entity.dart';
import '../model/category_list_entity.dart';
import 'api_exception.dart';
import 'network_config.dart';

final RequestClient requestClient = RequestClient();

class RequestClient {
  late Dio _dio;
  static final RequestClient _singletonRequestClient =
      RequestClient._internal();

  factory RequestClient() {
    return _singletonRequestClient;
  }
  final cookieJar = CookieJar();
  RequestClient._internal() {
    ///初始化 dio 配置
    var options = BaseOptions(
        baseUrl: NetWorkConfig.baseUrl,
        connectTimeout: NetWorkConfig.connectTimeOut,
        receiveTimeout: NetWorkConfig.readTimeOut,
        sendTimeout: NetWorkConfig.writeTimeOut);
    _dio = Dio(options);
    _dio.interceptors
      .add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
      // ..add(CookieManager(cookieJar));
  }

  /// dio 本身提供了get 、post 、put 、delete 等一系列 http 请求方法,最终都是调用request,直接封装request就行
  Future<T?> request<T>(
    String url, {
    required String method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError, //用于错误信息处理的回调
  }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;

      data = _convertRequestData(data);

      Response response = await _dio.request(url,
          queryParameters: queryParameters, data: data, options: options);

      return _handleResponse<T>(response);
    } catch (e) {
      ///创建 ApiException ，调用 onError，当 onError 返回为 true 时即错误信息已被调用方处理，则不抛出异常，否则抛出异常。
      var exception = ApiException.from(e);
      if (kDebugMode) {
        print("error:${exception.stackInfo}");
      }
      Fluttertoast.showToast(msg: exception.message ?? "未知错误");
      if (onError?.call(exception) != true) {
        throw exception;
      }
    }
    return null;
  }

  ///将请求 data 数据先使用 jsonEncode 转换为字符串，再使用 jsonDecode 方法将字符串转换为 Map。
  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      if (T.toString() == (BannerEntity).toString()) {
        var raw = BannerEntity.fromJson(response.data);
        if(raw.errorCode!=0){
          Fluttertoast.showToast(msg: raw.errorMsg);
        }
        return raw as T;
      } else if (T.toString() == (ArticleListEntity).toString()) {
        var raw = ArticleListEntity.fromJson(response.data);
        if(raw.errorCode!=0){
          Fluttertoast.showToast(msg: raw.errorMsg);
        }
        return raw as T;
      } else if (T.toString() == (ProjectListEntity).toString()) {
        var raw = ProjectListEntity.fromJson(response.data);
        if(raw.errorCode!=0){
          Fluttertoast.showToast(msg: raw.errorMsg);
        }
        return raw as T;
      } else if (T.toString() == (CategoryListEntity).toString()) {
        var raw = CategoryListEntity.fromJson(response.data);
        if (raw.errorCode != 0) {
          Fluttertoast.showToast(msg: raw.errorMsg);
        }
        return raw as T;
      }else if(T.toString()==(PublicAccount).toString()){
        var raw = PublicAccount.fromJson(response.data);
        if (raw.errorCode != 0) {
          Fluttertoast.showToast(msg: raw.errorMsg);
        }
        return raw as T;
      }else{
        var baseEntity = BaseEntity.fromJson(response.data);
        if(baseEntity.errorCode!=0){
          Fluttertoast.showToast(msg: baseEntity.errorMsg);
        }
        return baseEntity as T;
      }

    } else {
      var exception =
          ApiException(response.statusCode, ApiException.unknownException);
      throw exception;
    }
  }

  Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "Get",
        queryParameters: queryParameters,
        headers: headers,
        onError: onError);
  }

  Future<T?> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "POST",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  Future<T?> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "DELETE",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  Future<T?> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "PUT",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }
}
