import 'package:realorfake/data/responses/api_responses.dart';

class UserModel implements Serializable {
  String? token;
  DateTime? expireTime;
  bool? isLogin;
  String? playerName;
  String? userId;
  String? userRole;
  String? profilePic;
  String? userType;

  UserModel({
    this.token,
    this.expireTime,
    this.isLogin,
    this.playerName,
    this.userId,
    this.userRole,
    this.profilePic,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        expireTime: json["expireTime"] == null
            ? null
            : DateTime.parse(json["expireTime"]),
        isLogin: json["isLogin"],
        playerName: json["playerName"],
        userId: json["userId"],
        userRole: json["userRole"],
        profilePic: json["profilePic"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expireTime": expireTime?.toIso8601String(),
        "isLogin": isLogin,
        "playerName": playerName,
        "userId": userId,
        "userRole": userRole,
        "profilePic": profilePic,
        "userType": userType,
      };
}
