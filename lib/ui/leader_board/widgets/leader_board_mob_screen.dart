import 'package:dotted_border/dotted_border.dart';
import 'package:realorfake/ui/empty_list/empty_list_screen.dart';
import 'package:realorfake/ui/leader_board/leader_board_bloc.dart';
import 'package:realorfake/ui/leader_board/leader_board_state.dart';
import 'package:realorfake/ui/leader_board/view/item_leader.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class LeaderBoardMobScreen extends StatefulWidget {
  const LeaderBoardMobScreen({super.key});

  @override
  State<LeaderBoardMobScreen> createState() => _LeaderBoardMobScreenState();
}

class _LeaderBoardMobScreenState extends State<LeaderBoardMobScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.instance.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScaffold(
        background: Colors.transparent,
        backgroundAppbar: Colors.transparent,
        backgroundStatusBar: Colors.transparent,
        titleColor: AppColors.instance.white,
        titleSize: 24,
        title: "Leaderboard",
        body: BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
          buildWhen: (previous, current) =>
              current.runtimeType != LeaderBoardLoadMoreState,
          builder: (context, state) {
            if (state is LeaderBoardLoadingState) {
              return const CustomLoadingWidget();
            }
            if (state is LeaderBoardErrorState) {
              return ErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<LeaderBoardBloc>().loadData();
                },
              );
            }
            if (state is LeaderBoardLoadedState) {
              var mList = state.mList;
              var obj1 = context.read<LeaderBoardBloc>().getValueByIndex(0);
              var obj2 = context.read<LeaderBoardBloc>().getValueByIndex(1);
              var obj3 = context.read<LeaderBoardBloc>().getValueByIndex(2);
              var objOwn =
                  context.read<LeaderBoardBloc>().getUserLeaderPosition();
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: context.read<LeaderBoardBloc>().scrollController,
                child: Column(
                  children: [
                    spaceVertical10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<LeaderBoardBloc>().index = 0;
                            context.read<LeaderBoardBloc>().getLeaderBoard();
                            setState(() {});
                          },
                          child: Container(
                            width: (AppSizes.instance.getScreenWidth(context) /
                                    3) -
                                15,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: context.read<LeaderBoardBloc>().index == 0
                                  ? AppColors.instance.buttonColor1
                                  : AppColors.instance.appColor,
                            ),
                            child: Center(
                                child: CustomSubHeaderWidget(
                              "Today",
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<LeaderBoardBloc>().index = 1;
                            context.read<LeaderBoardBloc>().getLeaderBoard();
                            setState(() {});
                          },
                          child: Container(
                            width: (AppSizes.instance.getScreenWidth(context) /
                                    3) -
                                15,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: context.read<LeaderBoardBloc>().index == 1
                                  ? AppColors.instance.buttonColor1
                                  : AppColors.instance.appColor,
                            ),
                            child: Center(
                                child: CustomSubHeaderWidget(
                              "Weekly",
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<LeaderBoardBloc>().index = 2;
                            context.read<LeaderBoardBloc>().getLeaderBoard();
                            setState(() {});
                          },
                          child: Container(
                            width: (AppSizes.instance.getScreenWidth(context) /
                                    3) -
                                15,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: context.read<LeaderBoardBloc>().index == 2
                                  ? AppColors.instance.buttonColor1
                                  : AppColors.instance.appColor,
                            ),
                            child: Center(
                                child: CustomSubHeaderWidget(
                              "All Time",
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        )
                      ],
                    ),
                    spaceVertical10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 1,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 95,
                              child: Stack(
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.Circle,
                                    dashPattern: const [7, 3],
                                    color: AppColors.instance.green,
                                    strokeWidth: 2,
                                    child: CustomImageLoadWidget(
                                      imageUrl: "${obj2.profileImage}",
                                      height: 80,
                                      width: 80,
                                      borderRadius: 100,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.instance.white,
                                      radius: 15,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.instance.green,
                                        radius: 14,
                                        child: Center(
                                          child: CustomSubHeaderWidget(
                                            "2",
                                            titleSize: 16,
                                            fontWeight: FontWeight.w700,
                                            textColor: AppColors.instance.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            spaceVertical10,
                            CustomSubHeaderWidget(
                              "${obj2.playerName}",
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              ellipsis: TextOverflow.ellipsis,
                            ),
                            spaceVertical10,
                            Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.instance.green,
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageLoadWidget(
                                    imageUrl: AppImages.instance.iconDiamond,
                                    height: 15,
                                    width: 15,
                                    imageColor: AppColors.instance.red,
                                  ),
                                  spaceHorizontal5,
                                  CustomSubHeaderWidget(
                                    "${obj2.totalPointsEarned ?? 0}",
                                    textColor: AppColors.instance.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 180,
                              child: Column(
                                children: [
                                  CustomImageLoadWidget(
                                    imageUrl: AppImages.instance.iconCrown,
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(
                                    height: 128,
                                    child: Stack(
                                      children: [
                                        DottedBorder(
                                          borderType: BorderType.Circle,
                                          dashPattern: const [7, 3],
                                          color: AppColors.instance.yellow,
                                          strokeWidth: 2,
                                          child: CustomImageLoadWidget(
                                            imageUrl: "${obj1.profileImage}",
                                            height: 110,
                                            width: 110,
                                            borderRadius: 100,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.instance.transparent,
                                            radius: 20,
                                            child: CircleAvatar(
                                              backgroundColor: AppColors
                                                  .instance.transparent,
                                              backgroundImage: AssetImage(
                                                  AppImages.instance.iconStar),
                                              radius: 20,
                                              child: Center(
                                                child: CustomSubHeaderWidget(
                                                  "1",
                                                  titleSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  textColor:
                                                      AppColors.instance.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            spaceVertical10,
                            CustomSubHeaderWidget(
                              "${obj1.playerName}",
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              ellipsis: TextOverflow.ellipsis,
                            ),
                            spaceVertical10,
                            Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.instance.yellow,
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageLoadWidget(
                                    imageUrl: AppImages.instance.iconDiamond,
                                    height: 15,
                                    width: 15,
                                    imageColor:
                                        AppColors.instance.appColorBottom,
                                  ),
                                  spaceHorizontal5,
                                  CustomSubHeaderWidget(
                                    "${obj1.totalPointsEarned ?? 0}",
                                    textColor: AppColors.instance.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 95,
                              child: Stack(
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.Circle,
                                    dashPattern: const [7, 3],
                                    color: AppColors.instance.blue,
                                    strokeWidth: 2,
                                    child: CustomImageLoadWidget(
                                      imageUrl: "${obj3.profileImage}",
                                      height: 80,
                                      width: 80,
                                      borderRadius: 100,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.instance.white,
                                      radius: 15,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.instance.blue,
                                        radius: 14,
                                        child: Center(
                                          child: CustomSubHeaderWidget(
                                            "3",
                                            titleSize: 16,
                                            fontWeight: FontWeight.w700,
                                            textColor: AppColors.instance.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            spaceVertical10,
                            CustomSubHeaderWidget(
                              "${obj3.playerName}",
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              ellipsis: TextOverflow.ellipsis,
                            ),
                            spaceVertical10,
                            Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.instance.blue,
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageLoadWidget(
                                    imageUrl: AppImages.instance.iconDiamond,
                                    height: 15,
                                    width: 15,
                                    imageColor: AppColors.instance.white,
                                  ),
                                  spaceHorizontal5,
                                  CustomSubHeaderWidget(
                                    "${obj3.totalPointsEarned ?? 0}",
                                    textColor: AppColors.instance.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    if (objOwn != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child:
                            ItemLeaderView(obj: objOwn, index: 0, isUser: true),
                      ),
                    spaceVertical30,
                    ListView.separated(
                      itemCount: mList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          index > 2 ? spaceVertical15 : spaceVertical0,
                      itemBuilder: (context, index) {
                        var obj = mList[index];
                        if (index > 2) {
                          return ItemLeaderView(obj: obj, index: index);
                        }
                        return Container();
                      },
                    ),
                    spaceVertical10,
                    if (!context.read<LeaderBoardBloc>().isMaxReached &&
                        mList.length >=
                            context.read<LeaderBoardBloc>().pageLimit)
                      const CustomLoadingWidget(),
                    spaceVertical30,
                  ],
                ),
              );
            }
            return const EmptyListScreen(message: "No data found!");
          },
        ),
      ),
    );
  }
}
