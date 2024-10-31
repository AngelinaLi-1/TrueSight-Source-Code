import 'package:realorfake/data/network/app_network.dart';
import 'package:realorfake/data/responses/api_responses.dart';
import 'package:realorfake/data/responses/avatar_model.dart';
import 'package:realorfake/data/responses/history_model.dart';
import 'package:realorfake/data/responses/leader_board_model.dart';
import 'package:realorfake/data/responses/question_model.dart';
import 'package:realorfake/data/responses/quiz_model.dart';
import 'package:realorfake/data/responses/total_points_model.dart';
import 'package:realorfake/data/responses/upcoming_quiz_model.dart';
import 'package:realorfake/data/responses/user_model.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ApiServices {
  static final ApiServices instance = ApiServices.internal();

  ApiServices.internal();

  factory ApiServices() => instance;

  Future<ApiResponse<AvatarModel>> getAvatars(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .get(endPointUrl: AppStrings.instance.avatar, body: parameter)
        .then((dynamic res) {
      return ApiResponse<AvatarModel>.fromJson(
          res, (data) => AvatarModel.fromJson(data));
    });
  }

  Future<ApiResponse<QuestionsModel>> getRandomQuiz(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .get(endPointUrl: AppStrings.instance.randomQuiz, body: parameter)
        .then((dynamic res) {
      return ApiResponse<QuestionsModel>.fromJson(
          res, (data) => QuestionsModel.fromJson(data));
    });
  }

  Future<ApiResponse<QuestionsModel>> getQuizById(
      {required Map<String, dynamic> parameter, required String quizId}) {
    return AppNetworkUtils.instance
        .get(
            endPointUrl: "${AppStrings.instance.quizById}/$quizId",
            body: parameter)
        .then((dynamic res) {
      return ApiResponse<QuestionsModel>.fromJson(
          res, (data) => QuestionsModel.fromJson(data));
    });
  }

  Future<ApiResponse<HistoryModel>> getHistory(
      {required Map<String, dynamic> parameter, required String playerId}) {
    return AppNetworkUtils.instance
        .post(
            endPointUrl: "${AppStrings.instance.history}$playerId",
            body: parameter)
        .then((dynamic res) {
      return ApiResponse<HistoryModel>.fromJson(
          res, (data) => HistoryModel.fromJson(data));
    });
  }

  Future<ApiResponse<TotalPointsModel>> getTotalPoints(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .get(endPointUrl: AppStrings.instance.totalPoints, body: parameter)
        .then((dynamic res) {
      return ApiResponse<TotalPointsModel>.fromJson(
          res, (data) => TotalPointsModel.fromJson(data));
    });
  }

  Future<ApiResponse<UpcomingQuizModel>> getUpcomingQuiz(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .post(endPointUrl: AppStrings.instance.upcomingQuiz, body: parameter)
        .then((dynamic res) {
      return ApiResponse<UpcomingQuizModel>.fromJson(
          res, (data) => UpcomingQuizModel.fromJson(data));
    });
  }

  Future<ApiResponse<LeaderBoardModel>> getLeaderBoard(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .post(endPointUrl: AppStrings.instance.leaderBoard, body: parameter)
        .then((dynamic res) {
      return ApiResponse<LeaderBoardModel>.fromJson(
          res, (data) => LeaderBoardModel.fromJson(data));
    });
  }

  Future<ApiResponse<UserModel>> createPlayer(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .post(endPointUrl: AppStrings.instance.createPlayer, body: parameter)
        .then((dynamic res) {
      return ApiResponse<UserModel>.fromJson(
          res, (data) => UserModel.fromJson(data));
    });
  }

  Future<ApiResponse<QuizModel>> createQuiz(
      {required Map<String, dynamic> parameter}) {
    return AppNetworkUtils.instance
        .post(endPointUrl: AppStrings.instance.createQuiz, body: parameter)
        .then((dynamic res) {
      return ApiResponse<QuizModel>.fromJson(
          res, (data) => QuizModel.fromJson(data));
    });
  }

  Future<ApiResponse<QuizModel>> submitAnswer(
      {required Map<String, dynamic> parameter, required String quizId}) {
    return AppNetworkUtils.instance
        .post(
            endPointUrl: "${AppStrings.instance.submitAnswer}$quizId",
            body: parameter)
        .then((dynamic res) {
      return ApiResponse<QuizModel>.fromJson(
          res, (data) => QuizModel.fromJson(data));
    });
  }
}
