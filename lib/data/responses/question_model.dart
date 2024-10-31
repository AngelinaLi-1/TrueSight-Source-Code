import 'package:realorfake/data/responses/api_responses.dart';

class QuestionsModel implements Serializable {
  String? questionId;
  String? questionTitle;
  String? questionDescription;
  String? language;
  int? timeToFinish;
  String? type;
  List<String>? options;
  String? correctAnswer;
  int? points;
  QuestionCategory? questionCategory;
  String? imageUrl;
  bool? isActive;
  DateTime? createdAt;

  QuestionsModel({
    this.questionId,
    this.questionTitle,
    this.questionDescription,
    this.language,
    this.timeToFinish,
    this.type,
    this.options,
    this.correctAnswer,
    this.points,
    this.questionCategory,
    this.imageUrl,
    this.isActive,
    this.createdAt,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        questionId: json["questionId"],
        questionTitle: json["questionTitle"],
        questionDescription: json["questionDescription"],
        language: json["language"],
        timeToFinish: json["timeToFinish"],
        type: json["type"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        correctAnswer: json["correctAnswer"],
        points: json["points"],
        questionCategory: json["questionCategory"] == null
            ? null
            : QuestionCategory.fromJson(json["questionCategory"]),
        imageUrl: json["imageUrl"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionTitle": questionTitle,
        "questionDescription": questionDescription,
        "language": language,
        "timeToFinish": timeToFinish,
        "type": type,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "correctAnswer": correctAnswer,
        "points": points,
        "questionCategory": questionCategory?.toJson(),
        "imageUrl": imageUrl,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class QuestionCategory {
  String? categoryId;
  String? categoryName;

  QuestionCategory({
    this.categoryId,
    this.categoryName,
  });

  factory QuestionCategory.fromJson(Map<String, dynamic> json) =>
      QuestionCategory(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
      };
}
