import 'package:realorfake/data/responses/leader_board_model.dart';
import 'package:realorfake/ui/leader_board/leader_board_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class LeaderBoardBloc extends Cubit<LeaderBoardState> {
  BuildContext context;
  int index = 0;
  int pageIndex = 1;
  int pageLimit = 10;
  bool isMaxReached = false;
  var scrollController = ScrollController();
  String userName = "";
  String userImage = "";
  List<LeaderBoardModel> mList = [];
  LeaderBoardBloc(this.context) : super(LeaderBoardStartedState()) {
    scrollController.addListener(_onScroll);
    loadData();
  }

  void loadData() async {
    userName =
        await AppPreferences.get(AppStrings.instance.userName, "Anonymous");
    userImage = await AppPreferences.get(AppStrings.instance.userImage, "");
    getLeaderBoard();
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
        getLeaderBoardLoadMore();
      }
    }
  }

  void getLeaderBoard() async {
    pageIndex = 1;
    isMaxReached = false;
    String boardType = BoardType.today.name;
    if (index == 0) {
      boardType = BoardType.today.name;
    } else if (index == 1) {
      boardType = BoardType.weekly.name;
    } else {
      boardType = BoardType.all.name;
    }
    try {
      Map<String, dynamic> parameters = {};
      parameters['page'] = pageIndex;
      parameters['limit'] = pageLimit;
      parameters['boardType'] = boardType;
      emit(LeaderBoardLoadingState());
      var response =
          await ApiServices.instance.getLeaderBoard(parameter: parameters);
      if (response.isSuccess) {
        mList = response.dataList ?? [];
        if (mList.isEmpty) {
          emit(LeaderBoardEmptyState());
        } else {
          emit(LeaderBoardLoadedState(mList: mList));
        }
      } else {
        emit(LeaderBoardErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(LeaderBoardErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(LeaderBoardErrorState(AppStrings.errorMessage));
    }
  }

  void getLeaderBoardLoadMore() async {
    try {
      pageIndex++;
      String boardType = BoardType.today.name;
      if (index == 0) {
        boardType = BoardType.today.name;
      } else if (index == 1) {
        boardType = BoardType.weekly.name;
      } else {
        boardType = BoardType.all.name;
      }
      Map<String, dynamic> parameters = {};
      parameters['page'] = pageIndex;
      parameters['limit'] = pageLimit;
      parameters['boardType'] = boardType;
      isMaxReached = true;
      emit(LeaderBoardLoadMoreState());
      var response =
          await ApiServices.instance.getLeaderBoard(parameter: parameters);
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
        emit(LeaderBoardLoadedState(mList: mList));
      }
    } on CustomApiException catch (e) {
      emit(LeaderBoardErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(LeaderBoardErrorState(AppStrings.errorMessage));
    }
  }

  LeaderBoardModel getValueByIndex(int index) {
    if (index >= 0 && index < mList.length) {
      return mList[index];
    } else {
      return LeaderBoardModel(
          playerName: "Anonymous",
          profileImage: AppImages.instance.avatar,
          totalPointsEarned: 0);
    }
  }

  LeaderBoardModel? getUserLeaderPosition() {
    LeaderBoardModel? result;
    try {
      result = mList.firstWhere(
        (element) => element.message != null && element.message!.isNotEmpty,
      );
    } catch (e) {
      result = null;
    }
    return result;
  }
}
