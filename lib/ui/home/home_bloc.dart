import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:realorfake/data/responses/avatar_model.dart';
import 'package:realorfake/data/responses/leader_board_model.dart';
import 'package:realorfake/data/responses/question_model.dart';
import 'package:realorfake/data/responses/quiz_model.dart';
import 'package:realorfake/data/responses/upcoming_quiz_model.dart';
import 'package:realorfake/ui/home/home_state.dart';
import 'package:realorfake/ui/home/views/add_name/add_name_bloc.dart';
import 'package:realorfake/ui/home/views/add_name/add_your_name_screen.dart';
import 'package:realorfake/ui/view_image/model/image_model.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HomeBloc extends Cubit<HomeState> {
  BuildContext context;
  int pageIndex = 0;
  String selectedOption = "";
  bool isQuizStarted = false;
  var carouselController = CarouselSliderController();
  var scrollController = ScrollController();
  final interval = const Duration(seconds: 1);
  int timerMaxSeconds = 300;
  Timer? timer;
  final timerUpdateStream = StreamController<String>.broadcast();
  String timerText = "0:00";
  String userName = "Anonymous";
  String userImage = "";
  int selectedIndex = 0;
  late AvatarModel avatarModel;
  String quizId = "";
  List<QuestionsModel> imgList = [];
  List<LeaderBoardModel> mListLeader = [];
  List<UpcomingQuizModel> mListUpcomingQuiz = [];
  bool isClickedUpcomingQuiz = false;

  HomeBloc(this.context) : super(HomeStartedState()) {
    loadData();
  }

  void nextQuestion() async {
    if (pageIndex < imgList.length - 1) {
      carouselController.nextPage();
    } else {
      await context.pushNamed(AppRoutes.instance.resultSummary);
      // ignore: use_build_context_synchronously
      context.pushNamedAndRemoveUntil(AppRoutes.instance.dashboard,
          predicate: (route) => false);
    }
  }

  @override
  Future<void> close() {
    stopTimeout();
    return super.close();
  }

  void stopTimeout() {
    if (timer != null) {
      timer?.cancel();
    }
  }

  DateTime? startTime;
  Duration? totalDuration;
  void startTimeout() {
    startTime = DateTime.now();
    totalDuration = Duration(seconds: timerMaxSeconds);

    Timer.periodic(interval, (timer) {
      this.timer = timer;
      final now = DateTime.now();
      final elapsed = now.difference(startTime!);

      final remainingDuration = totalDuration! - elapsed;
      final remainingSeconds = remainingDuration.inSeconds;

      timerText =
          '${(remainingSeconds ~/ 60).toString().padLeft(1, '0')}:${(remainingSeconds % 60).toString().padLeft(2, '0')}';
      timerUpdateStream.sink.add(timerText);

      if (remainingSeconds <= 0) {
        timeUpAlert();
        timerUpdateStream.sink.add("0:00");
        timer.cancel();
      }
    });
  }

  void timeUpAlert() {
    context.showAlertDialog(
      isShowSuccessImage: false,
      message: "The quiz timer has ended. Please try again.",
      okButtonText: "Retry",
      okButtonCallback: () {
        getRandomQuiz();
      },
    );
  }

  void startQuiz() {
    stopTimeout();
    isQuizStarted = true;
    selectedOption = "";
    pageIndex = 0;
    carouselController.jumpToPage(pageIndex);
    startTimeout();
  }

  void clearAll() {
    stopTimeout();
    isQuizStarted = false;
    selectedOption = "";
    pageIndex = 0;
  }

  void loadData() async {
    userName = await AppPreferences.get(AppStrings.instance.userName, userName);
    userImage =
        await AppPreferences.get(AppStrings.instance.userImage, userImage);
    selectedIndex = await AppPreferences.get(
        AppStrings.instance.selectedIndex, selectedIndex);
    if (userName.toLowerCase() == "anonymous") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        addName();
      });
    }
    getRandomQuiz();
  }

  void addName() async {
    if (isQuizStarted) {
      context.showAlertDialog(
        isShowSuccessImage: false,
        message:
            "Kindly complete the quiz, then you can update or quit the game.",
        okButtonText: "Okay",
      );
      return;
    }
    var map = {"name": "", "image": "", "selectedIndex": selectedIndex};
    if (userName.toLowerCase() != "anonymous") {
      map = {
        "name": userName,
        "image": userImage,
        "selectedIndex": selectedIndex,
      };
    }
    var result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: false,
      builder: (context) {
        return BlocProvider<AddNameBloc>(
          create: (context) => AddNameBloc(context, map),
          child: const AddYourNameScreen(),
        );
      },
    );
    createPlayer(result);
  }

  void viewImage(String? image, String? title, String? descriptions) {
    List<ImageModel> mList = [];
    mList.add(ImageModel(
        imagePath: image, imageTitle: title, descriptions: descriptions));
    context.pushNamed(AppRoutes.instance.viewImage, arguments: mList);
  }

  void createPlayer(Map<String, dynamic>? result) async {
    try {
      if (result != null) {
        userName = result['name'] ?? "Anonymous";
        userImage = result['image'] ?? "";
        selectedIndex = result['selectedIndex'] ?? 0;
      }
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      Map<String, dynamic> deviceDetails = {};
      String networkType = "other";
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        networkType = "mobile";
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        networkType = "wifi";
      }
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      String deviceId = await getUniqueDeviceId();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceDetails['model'] = androidInfo.model;
        deviceDetails['platform'] = "android";
        deviceDetails['osVersion'] = androidInfo.version.release;
        deviceDetails['manufacturer'] = androidInfo.manufacturer;
        deviceDetails['networkType'] = networkType;
        deviceDetails['appVersion'] = packageInfo.version;
        deviceDetails['fcmTokenId'] = "";
        deviceDetails['timeZone'] = currentTimeZone;
      }
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceDetails['model'] = iosInfo.model;
        deviceDetails['platform'] = "ios";
        deviceDetails['osVersion'] = iosInfo.systemVersion;
        deviceDetails['manufacturer'] = iosInfo.systemName;
        deviceDetails['networkType'] = networkType;
        deviceDetails['appVersion'] = packageInfo.version;
        deviceDetails['fcmTokenId'] = "";
        deviceDetails['timeZone'] = currentTimeZone;
      }
      Map<String, dynamic> parameters = {};
      parameters['uniqueDeviceId'] = deviceId;
      parameters['playerName'] = userName;
      parameters['profileImage'] = userImage;
      parameters['deviceDetails'] = deviceDetails;
      parameters['gender'] = selectedIndex == 1 ? "M" : "F";
      emit(HomeLoadingState());
      var response =
          await ApiServices.instance.createPlayer(parameter: parameters);
      if (response.isSuccess) {
        await AppPreferences.put(AppStrings.instance.userName, userName);
        await AppPreferences.put(AppStrings.instance.userImage, userImage);
        await AppPreferences.put(
            AppStrings.instance.selectedIndex, selectedIndex);
        await AppPreferences.put(
            AppStrings.instance.userToken, response.data?.token);
        AppStrings.token = response.data?.token ?? "";
        getRandomQuiz();
      } else {
        emit(HomeErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(HomeErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(HomeErrorState(AppStrings.errorMessage));
    }
  }

  void getRandomQuiz() async {
    try {
      Map<String, dynamic> parameters = {};
      emit(HomeLoadingState());
      var response =
          await ApiServices.instance.getRandomQuiz(parameter: parameters);
      Map<String, dynamic> paramLeader = {};
      paramLeader['page'] = 1;
      paramLeader['limit'] = 10;
      paramLeader['boardType'] = BoardType.all.name;
      var responseLeader =
          await ApiServices.instance.getLeaderBoard(parameter: paramLeader);
      var responseQuiz =
          await ApiServices.instance.getUpcomingQuiz(parameter: parameters);
      if (response.isSuccess) {
        imgList = response.dataList ?? [];
        mListLeader = responseLeader.dataList ?? [];
        mListUpcomingQuiz = responseQuiz.dataList ?? [];
        isClickedUpcomingQuiz = false;
        clearAll();
        emit(HomeLoadedState());
      } else {
        emit(HomeErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      if (e.message?.toLowerCase() == "authorization token missing") {
        emit(HomeTokenMissingState());
      } else if (e.message?.toLowerCase() == "invalid token") {
        createPlayer(null);
      } else {
        emit(HomeErrorState(e.message));
      }
    } catch (e) {
      safePrint(e);
      emit(HomeErrorState(AppStrings.errorMessage));
    }
  }

  void playUpcomingQuiz(
      String? quizId, bool isClickedUpcomingQuiz, int? timeToFinish) {
    if (isQuizStarted) {
      context.showAlertDialog(
        isShowSuccessImage: false,
        message: "Do you want to switch the quiz?",
        okButtonText: "Yes",
        okButtonCallback: () {
          getRandomQuizById(quizId, isClickedUpcomingQuiz, timeToFinish);
        },
        cancelButtonText: "Don't Switch",
      );
      return;
    }
    getRandomQuizById(quizId, isClickedUpcomingQuiz, timeToFinish);
  }

  void getRandomQuizById(
      String? quizId, bool isClickedUpcomingQuiz, int? timeToFinish) async {
    try {
      Map<String, dynamic> parameters = {};
      emit(HomeLoadingState());
      var response = await ApiServices.instance
          .getQuizById(parameter: parameters, quizId: quizId!);
      if (response.isSuccess) {
        imgList = response.dataList ?? [];
        this.isClickedUpcomingQuiz = isClickedUpcomingQuiz;
        timerMaxSeconds = timeToFinish ?? 300;
        clearAll();
        scrollToTop();
        emit(HomeLoadedState());
      } else {
        emit(HomeErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(HomeErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(HomeErrorState(AppStrings.errorMessage));
    }
  }

  void createQuiz() async {
    try {
      Map<String, dynamic> parameters = {};
      List<Map<String, dynamic>> questions = [];
      for (QuestionsModel obj in imgList) {
        Map<String, dynamic> param = {};
        param['questionId'] = obj.questionId;
        param['questionTitle'] = obj.questionTitle;
        questions.add(param);
      }
      parameters['questions'] = questions;
      emit(HomeCustomLoadingState());
      var response =
          await ApiServices.instance.createQuiz(parameter: parameters);
      if (response.isSuccess) {
        if (!isClickedUpcomingQuiz) {
          timerMaxSeconds = response.data?.timeToFinish ?? 300;
        }
        quizId = response.data?.quizId ?? "";
        startQuiz();
        emit(HomeLoadedState());
      } else {
        emit(HomeErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(HomeErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(HomeErrorState(AppStrings.errorMessage));
    }
  }

  void submitAnswer() async {
    if (selectedOption.isEmpty) {
      return showToast("Please choose an option");
    }
    try {
      Map<String, dynamic> parameters = {};
      bool isFinalStep = pageIndex == (imgList.length - 1) ? true : false;
      parameters['isFinalStep'] = isFinalStep;
      parameters['questionId'] = imgList[pageIndex].questionId;
      parameters['givenAnswer'] = selectedOption;
      emit(HomeCustomLoadingState());
      var response = await ApiServices.instance
          .submitAnswer(parameter: parameters, quizId: quizId);
      if (response.isSuccess) {
        if (isFinalStep) {
          navigateResult(response.data);
        } else {
          nextQuestion();
          emit(HomeLoadedState());
        }
      } else {
        emit(HomeErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(HomeErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(HomeErrorState(AppStrings.errorMessage));
    }
  }

  void navigateResult(QuizModel? data) async {
    stopTimeout();
    data?.imgList = imgList;
    await context.pushNamed(AppRoutes.instance.resultSummary, arguments: data);
    loadData();
  }

  void scrollToTop() {
    scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void nextQuiz() {
    if (isQuizStarted) {
      context.showAlertDialog(
          isShowSuccessImage: false,
          message: "Do you want to switch the quiz?",
          okButtonText: "Next Quiz",
          okButtonCallback: () {
            getRandomQuiz();
          },
          cancelButtonText: "Don't Switch");
    } else {
      getRandomQuiz();
    }
  }
}
