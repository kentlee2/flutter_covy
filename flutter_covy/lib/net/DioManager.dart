import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

//极简Dio封装
class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio() {
    // 在这里可以添加一些公共配置，如请求超时时间、拦截器等
    _dio.options.baseUrl = 'https://api.example.com';
    _dio.options.connectTimeout = const Duration(seconds: 30); // 设置请求超时时间为5秒

    // 添加拦截器
    _dio.interceptors.add(
      DioCacheInterceptor(
          options: CacheOptions(
        store: MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
        hitCacheOnErrorExcept: [], // for offline behaviour
      )),
    );
  }

  // 在这里添加封装后的网络请求方法

  Future<Response> fetchData(String path,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
    } catch (e) {
      if (e is DioException) {
        // DioError 是 Dio 组件的异常类型，可以根据不同的错误类型进行处理
        if (e.type == DioExceptionType.connectionTimeout) {
          throw Exception('连接超时，请检查网络连接');
        } else if (e.type == DioExceptionType.badResponse) {
          // 如果服务器返回了错误响应，可以通过 e.response 来获取响应信息
          final statusCode = e.response?.statusCode;
          final errorMessage = e.response?.statusMessage;
          throw Exception('请求失败：$statusCode $errorMessage');
        } else {
          throw Exception('请求失败，请稍后重试');
        }
      } else {
        throw Exception('网络请求失败');
      }
    }
  }
}
