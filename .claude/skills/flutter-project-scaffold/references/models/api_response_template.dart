import 'package:PROJECT_NAME/http/models/result.dart';

/// 注释：返回实体抽象类
/// 时间：2022/11/5 0005 20:17
/// 作者：作者名
abstract class BaseResponse<T> implements Result<T> {
  Map responseMap = {};
  int code = -1;
  String msg = "";

  /// 注释：设置请求返回
  /// 时间：2022/11/5 0005 18:21
  /// 作者：作者名
  void setResponse(Map responseMap) {
    this.responseMap = responseMap;
  }

  /// 注释：设置Code
  /// 时间：2022/11/7 0007 20:44
  /// 作者：作者名
  void setCode(int code) {
    this.code = code;
  }

  /// 注释：设置Msg
  /// 时间：2022/11/7 0007 20:45
  /// 作者：作者名
  void setMsg(String msg) {
    this.msg = msg;
  }

  /// 注释：是否成功
  /// 时间：2023/12/25 10:52
  /// 作者：作者名
  bool isSuccess() {
    return code == 0;
  }

  /// 注释：获取接口提示
  /// 时间：2023/12/25 11:05
  /// 作者：作者名
  String getDataMsg() {
    return msg;
  }

  @override
  get data {
    BaseResponse response = getData(responseMap);
    response.setCode(code);
    response.setMsg(msg);
    response.setResponse(responseMap);
    return response as T;
  }

  /// 注释：获取数据
  /// 时间：2022/11/5 0005 20:14
  /// 作者：作者名
  getData(Map responseMap);
}
