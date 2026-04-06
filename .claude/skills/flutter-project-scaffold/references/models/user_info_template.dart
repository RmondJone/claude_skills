import 'package:PROJECT_NAME/http/models/response.dart';

/// 注释：用户信息模型
/// 时间：2022/11/5 0005 20:17
/// 作者：作者名
class UserInfo extends BaseResponse<UserInfo> {
  String? userId;
  String? userName;
  String? avatar;
  String? phone;
  String? email;

  @override
  getData(Map responseMap) {
    return UserInfo()
      ..userId = responseMap['userId']
      ..userName = responseMap['userName']
      ..avatar = responseMap['avatar']
      ..phone = responseMap['phone']
      ..email = responseMap['email'];
  }
}

/// 注释：用户信息请求模型
/// 时间：2022/11/5 0005 20:17
/// 作者：作者名
class UserInfoRequest {
  String? userId;

  UserInfoRequest({this.userId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}
