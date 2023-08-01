
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

import '../logger.dart';

//Dio网络请求封装
class AppNet extends GetConnect{

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = 'https://www.wanandroid.com';

    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addResponseModifier((request, response) {
      loggerArray([response.statusCode,request.url.toString(),response.bodyString], name: "RESPONSE" );
      return response;
    });
  }

  AppNet._internal();

  static AppNet? instance;

  static getInstance() {
    if (instance == null) {
      instance = AppNet._internal();
      instance?.onInit();
    }
    return instance;
  }

  factory AppNet() => getInstance();


  Stream<Response<T>> getStream<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query, Decoder<T>? decoder}) {
    Future<Response<T>> future = get(url, headers:headers, contentType:contentType, query:query, decoder:decoder);
    return future.asStream();
  }


  @override
  Future<Response<T>> get<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query, Decoder<T>? decoder}) {
    loggerArray(['GET请求参数',url,headers,contentType,query]);
    return super.get(url, headers:headers, contentType:contentType, query:query, decoder:decoder);
  }


  @override
  Future<Response<T>> post<T>(String? url, body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query, Decoder<T>? decoder, Progress? uploadProgress}) {
    final bodyData = (body != null && body is FormData) ? body.fields.map((e) => '${e.key}:${e.value}').toList() : body;
    loggerArray(['POST请求参数',url,bodyData,contentType,headers,query]);
    return super.post(url, body, contentType: contentType, headers:headers, query:query, decoder:decoder, uploadProgress:uploadProgress);
  }


}