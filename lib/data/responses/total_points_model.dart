import 'package:realorfake/data/responses/api_responses.dart';

class TotalPointsModel implements Serializable {
  int? totalPointsEarned;
  String? playerName;

  TotalPointsModel({
    this.totalPointsEarned,
    this.playerName,
  });

  factory TotalPointsModel.fromJson(Map<String, dynamic> json) =>
      TotalPointsModel(
        totalPointsEarned: json["totalPointsEarned"],
        playerName: json["playerName"],
      );

  Map<String, dynamic> toJson() => {
        "totalPointsEarned": totalPointsEarned,
        "playerName": playerName,
      };
}
