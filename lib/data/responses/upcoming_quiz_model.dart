import 'package:realorfake/data/responses/api_responses.dart';

class UpcomingQuizModel implements Serializable {
  String? quizId;
  String? title;
  String? description;
  Category? category;
  String? language;
  int? timeToFinish;
  String? startTime;
  String? endTime;
  String? type;
  int? playersAttempted;
  int? passingCriteria;
  int? playersSuccess;
  int? playersFailed;
  DateTime? startDate;
  DateTime? endDate;
  List<Question>? questions;

  UpcomingQuizModel({
    this.quizId,
    this.title,
    this.description,
    this.category,
    this.language,
    this.timeToFinish,
    this.startTime,
    this.endTime,
    this.type,
    this.playersAttempted,
    this.passingCriteria,
    this.playersSuccess,
    this.playersFailed,
    this.startDate,
    this.endDate,
    this.questions,
  });

  factory UpcomingQuizModel.fromJson(Map<String, dynamic> json) =>
      UpcomingQuizModel(
        quizId: json["quizId"],
        title: json["title"],
        description: json["description"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        language: json["language"],
        timeToFinish: json["timeToFinish"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        type: json["type"],
        playersAttempted: json["playersAttempted"],
        passingCriteria: json["passingCriteria"],
        playersSuccess: json["playersSuccess"],
        playersFailed: json["playersFailed"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quizId": quizId,
        "title": title,
        "description": description,
        "category": category?.toJson(),
        "language": language,
        "timeToFinish": timeToFinish,
        "startTime": startTime,
        "endTime": endTime,
        "type": type,
        "playersAttempted": playersAttempted,
        "passingCriteria": passingCriteria,
        "playersSuccess": playersSuccess,
        "playersFailed": playersFailed,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Category {
  Category();

  factory Category.fromJson(Map<String, dynamic> json) => Category();

  Map<String, dynamic> toJson() => {};
}

class Question {
  String? questionId;
  String? questionTitle;

  Question({
    this.questionId,
    this.questionTitle,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["questionId"],
        questionTitle: json["questionTitle"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionTitle": questionTitle,
      };
}
