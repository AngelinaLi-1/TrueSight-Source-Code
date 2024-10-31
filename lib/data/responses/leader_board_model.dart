import 'package:realorfake/data/responses/api_responses.dart';

class LeaderBoardModel implements Serializable {
  int? totalPointsEarned;
  int? totalPoints;
  String? playerName;
  String? profileImage;
  String? badge;
  int? rank;
  int? totalQuizPlayed;
  String? uniqueDeviceId;
  String? message;

  LeaderBoardModel({
    this.totalPointsEarned,
    this.totalPoints,
    this.playerName,
    this.profileImage,
    this.badge,
    this.rank,
    this.totalQuizPlayed,
    this.uniqueDeviceId,
    this.message,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
        totalPointsEarned: json["totalPointsEarned"],
        totalPoints: json["totalPoints"],
        playerName: json["playerName"],
        profileImage: json["profileImage"],
        badge: json["badge"],
        rank: json["rank"],
        totalQuizPlayed: json["totalQuizPlayed"],
        uniqueDeviceId: json["uniqueDeviceId"],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "totalPointsEarned": totalPointsEarned,
        "totalPoints": totalPoints,
        "playerName": playerName,
        "profileImage": profileImage,
        "badge": badge,
        "rank": rank,
        "totalQuizPlayed": totalQuizPlayed,
        "uniqueDeviceId": uniqueDeviceId,
      };
}
