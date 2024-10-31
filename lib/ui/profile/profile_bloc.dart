import 'package:realorfake/data/responses/history_model.dart';
import 'package:realorfake/ui/profile/profile_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ProfileBloc extends Cubit<ProfileState> {
  BuildContext context;
  String name = "";
  String image = "";
  List<HistoryModel> mList = [];
  String totalPoints = "";
  int pageIndex = 1;
  int pageLimit = 10;
  bool isMaxReached = false;
  String uniqueId = "";
  var scrollController = ScrollController();
  ProfileBloc(this.context) : super(ProfileStartedState()) {
    scrollController.addListener(_onScroll);
    loadData();
  }

  void loadData() async {
    uniqueId = await getUniqueDeviceId();
    name = await AppPreferences.get(AppStrings.instance.userName, "Anonymous");
    image = await AppPreferences.get(
        AppStrings.instance.userImage, AppImages.instance.avatar);
    getHistory();
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 1) {
      if (!isMaxReached) {
        getHistoryLoadMore();
      }
    }
  }

  void getHistory() async {
    try {
      Map<String, dynamic> parameters = {};

      emit(ProfileLoadingState());
      var responseTotal =
          await ApiServices.instance.getTotalPoints(parameter: parameters);
      Map<String, dynamic> parametersHistory = {};
      parametersHistory["page"] = 1;
      parametersHistory["limit"] = 20;
      var response = await ApiServices.instance
          .getHistory(parameter: parametersHistory, playerId: uniqueId);
      if (response.isSuccess) {
        mList = response.dataList ?? [];
        if ((responseTotal.dataList ?? []).isNotEmpty) {
          totalPoints = "${responseTotal.dataList![0].totalPointsEarned}";
        }
        emit(ProfileLoadedState());
      } else {
        emit(ProfileErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(ProfileErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(ProfileErrorState(AppStrings.errorMessage));
    }
  }

  void getHistoryLoadMore() async {
    try {
      pageIndex++;
      Map<String, dynamic> parameters = {};
      parameters['page'] = pageIndex;
      parameters['limit'] = pageLimit;
      isMaxReached = true;
      emit(ProfileLoadMoreState());
      var response = await ApiServices.instance
          .getHistory(parameter: parameters, playerId: uniqueId);
      if (response.isSuccess) {
        var mListLoad = response.dataList ?? [];
        if (mListLoad.isNotEmpty) {
          mList = [...mList, ...mListLoad];
          if (mListLoad.length < pageLimit) {
            isMaxReached = true;
          } else {
            isMaxReached = false;
          }
        } else {
          isMaxReached = true;
        }
        emit(ProfileLoadedState());
      }
    } on CustomApiException catch (e) {
      emit(ProfileErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(ProfileErrorState(AppStrings.errorMessage));
    }
  }
}
