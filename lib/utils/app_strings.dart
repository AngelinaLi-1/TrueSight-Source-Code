class AppStrings {
  static final AppStrings instance = AppStrings._internal();

  factory AppStrings() {
    return instance;
  }
  AppStrings._internal();

  final String appName = "TrueSight";
  static const String baseUrl = 'https://realorfakeapi.bitlyze.com/api/v1/';
  static String token = "";

  String avatar = "user/get-avatars";
  String createPlayer = "user/create-player";
  String randomQuiz = "quiz/get-random-quiz";
  String createQuiz = "quiz/create-random-quiz";
  String submitAnswer = "question/attempted-answer-rate/";
  String leaderBoard = "quiz/get-leader-board";
  String upcomingQuiz = "quiz/get-upcoming-quiz";
  String quizById = "quiz/get-quiz-by-id-for-player";
  String history = "quiz/get-player-history/";
  String totalPoints = "quiz/get-player-total-point";

  String isIntroFirst = "isIntroFirst";
  String userToken = "userToken";
  String userName = "userName";
  String userImage = "userImage";
  String selectedIndex = "selectedIndex";

  static String errorMessage = "We're sorry, but an error occurred.";
}
