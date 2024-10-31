import 'package:realorfake/data/responses/api_responses.dart';
import 'package:realorfake/data/responses/question_model.dart';

class QuizModel implements Serializable {
  String? quizId;
  String? uniqueDeviceId;
  String? title;
  String? description;
  String? language;
  int? timeToFinish;
  String? startTime;
  String? endTime;
  String? type;
  List<Question>? questions;
  bool? isRandom;
  int? impression;
  int? playersAttempted;
  int? passingCriteria;
  int? playersSuccess;
  int? playersFailed;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  DateTime? createdAt;
  int? totalPointsEarned;
  int? totalPoints;
  List<QuestionsModel> imgList;

  QuizModel({
    this.quizId,
    this.uniqueDeviceId,
    this.title,
    this.description,
    this.language,
    this.timeToFinish,
    this.startTime,
    this.endTime,
    this.type,
    this.questions,
    this.isRandom,
    this.impression,
    this.playersAttempted,
    this.passingCriteria,
    this.playersSuccess,
    this.playersFailed,
    this.startDate,
    this.endDate,
    this.isActive,
    this.createdAt,
    this.totalPointsEarned,
    this.totalPoints,
    this.imgList = const [],
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        quizId: json["quizId"],
        uniqueDeviceId: json["uniqueDeviceId"],
        title: json["title"],
        description: json["description"],
        language: json["language"],
        timeToFinish: json["timeToFinish"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        type: json["type"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        isRandom: json["isRandom"],
        impression: json["impression"],
        playersAttempted: json["playersAttempted"],
        passingCriteria: json["passingCriteria"],
        playersSuccess: json["playersSuccess"],
        playersFailed: json["playersFailed"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        isActive: json["isActive"],
        totalPointsEarned: json["totalPointsEarned"],
        totalPoints: json["totalPoints"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "quizId": quizId,
        "title": title,
        "description": description,
        "language": language,
        "timeToFinish": timeToFinish,
        "startTime": startTime,
        "endTime": endTime,
        "type": type,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "isRandom": isRandom,
        "impression": impression,
        "playersAttempted": playersAttempted,
        "passingCriteria": passingCriteria,
        "playersSuccess": playersSuccess,
        "playersFailed": playersFailed,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class Question {
  String? questionTitle;
  String? questionId;
  String? givenAnswer;
  String? correctAnswer;
  String? points;
  String? isCorrect;

  Question({
    this.questionTitle,
    this.questionId,
    this.givenAnswer,
    this.correctAnswer,
    this.points,
    this.isCorrect,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionTitle: json["questionTitle"],
        questionId: json["questionId"],
        givenAnswer: json["givenAnswer"],
        correctAnswer: json["correctAnswer"],
        points: json["points"],
        isCorrect: json["isCorrect"],
      );

  Map<String, dynamic> toJson() => {
        "questionTitle": questionTitle,
        "questionId": questionId,
        "givenAnswer": givenAnswer,
        "correctAnswer": correctAnswer,
        "points": points,
        "isCorrect": isCorrect,
      };
}
