import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/10.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class DioUtils {
  Dio _dio;
  // 工厂模式
  factory DioUtils() => _getInstance();

  static DioUtils get instance => _getInstance();
  static DioUtils _instance;

  DioUtils._internal() {
    // 初始化
    _dio = new Dio();
  }

  static DioUtils _getInstance() {
    if (_instance == null) {
      _instance = new DioUtils._internal();
    }
    return _instance;
  }

  /// get 请求
  ///[url]请求链接
  ///[queryParameters]请求参数
  ///[cancelTag] 取消网络请求的标识
  Future<ResponseInfo> getRequest(
      {@required String url,
      Map<String, dynamic> queryParameters,
      CancelToken cancelTag}) async {
    //发起get请求
    try {
      Response response = await _dio.get(url,
          queryParameters: queryParameters, cancelToken: cancelTag);
      //响应数据
      dynamic responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        Map<String, dynamic> responseMap = responseData;
        int code = responseMap["code"];
        if (code == 200) {
          //业务代码处理正常
          //获取数据
          dynamic data = responseMap["data"];
          return ResponseInfo(data: data);
        } else {
          //业务代码异常
          return ResponseInfo.error(code: responseMap["code"]);
        }
      }
    } catch (e, s) {
      errorController(e, s);
    }
  }
  /// post 请求
  ///[url]请求链接
  ///[formDataMap]formData 请求参数
  ///[jsonMap] JSON 格式
  Future<ResponseInfo> postRequest(
      {@required String url,
      Map<String, dynamic> formDataMap,
      Map<String, dynamic> jsonMap,
      CancelToken cancelTag}) async {
    FormData form;
    if (formDataMap != null) {
      form = FormData.fromMap(formDataMap);
    }

    //发起post请求
    try {
      Response response = await _dio.post(url,
          data: form == null ? jsonMap : form, cancelToken: cancelTag);
      //响应数据
      dynamic responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        Map<String, dynamic> responseMap = responseData;
        int code = responseMap["code"];
        if (code == 200) {
          //业务代码处理正常
          //获取数据
          dynamic data = responseMap["data"];
          return ResponseInfo(data: data);
        } else {
          //业务代码异常
          return ResponseInfo.error(code: responseMap["code"]);
        }
      }
    } catch (e, s) {
      errorController(e, s);
    }
  }

  void errorController(e, StackTrace s) {
    //网络处理错误
    if (e is DioError) {
      DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          //超时
          break;
        case DioErrorType.SEND_TIMEOUT:
          //请求超时
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          //响应超时
          break;
        case DioErrorType.RESPONSE:
          // 响应错误
          break;
        case DioErrorType.CANCEL:
          // 取消操作
          break;
        case DioErrorType.DEFAULT:
          // 默认自定义其他异常
          break;
      }
    } else {
      //其他错误
    }
  }
}

class ResponseInfo {
  bool success;

  int code;
  dynamic data;

  ResponseInfo({this.success = true, this.code = 200, this.data});

  ResponseInfo.error({this.success = false, this.code = 201});
}
