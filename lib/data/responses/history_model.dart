import 'package:realorfake/data/responses/api_responses.dart';

class HistoryModel implements Serializable {
  int? totalPointsEarned;
  int? totalPoints;
  String? uniqueDeviceId;
  String? quizName;
  String? timeTaken;

  HistoryModel({
    this.totalPointsEarned,
    this.totalPoints,
    this.uniqueDeviceId,
    this.quizName,
    this.timeTaken,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        totalPointsEarned: json["totalPointsEarned"],
        totalPoints: json["totalPoints"],
        uniqueDeviceId: json["uniqueDeviceId"],
        quizName: json["quizName"],
        timeTaken: json["timeTaken"],
      );

  Map<String, dynamic> toJson() => {
        "totalPointsEarned": totalPointsEarned,
        "totalPoints": totalPoints,
        "uniqueDeviceId": uniqueDeviceId,
        "quizName": quizName,
        "timeTaken": timeTaken,
      };
}
