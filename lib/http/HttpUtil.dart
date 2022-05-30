import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
///网络请求

class HttpUtil{

  Dio? _dio;

  //单例模式
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;
  HttpUtil._internal(){
    init();
  }

  init(){
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "http://192.168.0.254:8080",
      connectTimeout: 5000,
      responseType: ResponseType.json,
    );
    _dio = Dio(baseOptions);
    var cookieJar=CookieJar();
    _dio?.interceptors.add(CookieManager(cookieJar));
  }

  Future postRequestWithJson(String url,{String method = "post",Map<String,dynamic>? data}) async{
    Options options = Options(method: method);
    try{
      final response =  await _dio?.post(url,data: data,options: options);
      return response;
    } on DioError catch(error){
      throw error;
    }


  }

  // 请求(默认post)
  Future post_requset(String url,{String method = "post",Map<String,dynamic>? params}) async{
    Options options = Options(method: method);
    try{
      final result = await _dio?.request(url,queryParameters: params,options: options);
      return result;
    } on DioError catch(error){
      throw error;
    }
  }


  // 请求(默认get)
  Future get_requset(String url,{String method = "get"}) async{
    Options options = Options(method: method);
    try{
      final result = await _dio?.request(url,options: options);
      return result;
    } on DioError catch(error){
      throw error;
    }
  }

  //带参数的get
  Future get_param_requset(String url,{String method = "get",Map<String,dynamic>? params}) async{
    Options options = Options(method: method);
    try{
      final result = await _dio?.request(url,queryParameters: params,options: options);
      return result;
    } on DioError catch(error){
      throw error;
    }
  }
}