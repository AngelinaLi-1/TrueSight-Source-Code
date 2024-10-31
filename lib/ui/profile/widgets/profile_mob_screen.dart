import 'package:dotted_border/dotted_border.dart';
import 'package:realorfake/ui/profile/profile_bloc.dart';
import 'package:realorfake/ui/profile/profile_state.dart';
import 'package:realorfake/ui/profile/views/item_recent_quiz.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ProfileMobScreen extends StatefulWidget {
  const ProfileMobScreen({super.key});

  @override
  State<ProfileMobScreen> createState() => _ProfileMobScreenState();
}

class _ProfileMobScreenState extends State<ProfileMobScreen> {
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
        isShowAppBar: false,
        background: Colors.transparent,
        backgroundAppbar: Colors.transparent,
        backgroundStatusBar: Colors.transparent,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState || state is ProfileStartedState) {
              return const CustomLoadingWidget();
            }
            if (state is ProfileErrorState) {
              return ErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<ProfileBloc>().loadData();
                },
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: context.read<ProfileBloc>().scrollController,
              child: Column(
                children: [
                  spaceVertical10,
                  Column(
                    children: [
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
                                imageUrl: context.read<ProfileBloc>().image,
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
                                backgroundColor: AppColors.instance.transparent,
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.instance.transparent,
                                  backgroundImage:
                                      AssetImage(AppImages.instance.iconStar),
                                  radius: 20,
                                  child: Center(
                                    child: CustomSubHeaderWidget(
                                      "1",
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
                        context.read<ProfileBloc>().name,
                        textColor: AppColors.instance.white,
                        fontWeight: FontWeight.w700,
                        titleSize: 24,
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
                              imageColor: AppColors.instance.appColorBottom,
                            ),
                            spaceHorizontal5,
                            CustomSubHeaderWidget(
                              context.read<ProfileBloc>().totalPoints,
                              textColor: AppColors.instance.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                  spaceVertical20,
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomSubHeaderWidget(
                      "Recent Quiz",
                      textColor: AppColors.instance.white,
                      titleSize: 18,
                    ),
                  ),
                  spaceVertical20,
                  if (context.read<ProfileBloc>().mList.isEmpty) ...[
                    spaceVertical100,
                    CustomHeaderWidget(
                      "No recent quiz play found!",
                      textSize: 14,
                      fontWeight: FontWeight.w400,
                      titleColor: AppColors.instance.white,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                  if (context.read<ProfileBloc>().mList.isNotEmpty)
                    ListView.separated(
                      itemCount: context.read<ProfileBloc>().mList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => spaceVertical15,
                      itemBuilder: (context, index) {
                        var obj = context.read<ProfileBloc>().mList[index];
                        return ItemRecentQuizView(obj: obj);
                      },
                    ),
                  spaceVertical10,
                  if (!context.read<ProfileBloc>().isMaxReached &&
                      context.read<ProfileBloc>().mList.length >=
                          context.read<ProfileBloc>().pageLimit)
                    const CustomLoadingWidget(),
                  spaceVertical30,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
