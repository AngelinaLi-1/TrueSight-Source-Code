import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:realorfake/ui/home/home_bloc.dart';
import 'package:realorfake/ui/home/home_state.dart';
import 'package:realorfake/ui/home/views/home_header.dart';
import 'package:realorfake/ui/home/views/home_slider.dart';
import 'package:realorfake/ui/home/views/item_upcoming_quiz.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HomeMobScreen extends StatefulWidget {
  const HomeMobScreen({super.key});

  @override
  State<HomeMobScreen> createState() => _HomeMobScreenState();
}

class _HomeMobScreenState extends State<HomeMobScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.instance.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeCustomLoadingState) {
            CustomProgressBar.show(context);
          } else {
            CustomProgressBar.hide();
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState || state is HomeStartedState) {
            return const CustomLoadingWidget();
          }
          if (state is HomeErrorState) {
            return ErrorScreen(
              message: state.message,
              onRetry: () {
                context.read<HomeBloc>().loadData();
              },
            );
          }
          if (state is HomeTokenMissingState) {
            return Container();
          }
          return CustomScaffold(
            isShowAppBar: false,
            sidePadding: 0,
            background: Colors.transparent,
            backgroundAppbar: Colors.transparent,
            backgroundStatusBar: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: context.read<HomeBloc>().scrollController,
              child: Column(
                children: [
                  spaceVertical5,
                  HomeHeaderView(
                    onClickProfile: () {
                      context.read<HomeBloc>().addName();
                    },
                  ),
                  spaceVertical25,
                  if (context.read<HomeBloc>().imgList.isEmpty &&
                      context.read<HomeBloc>().mListLeader.isEmpty &&
                      context.read<HomeBloc>().mListUpcomingQuiz.isEmpty) ...[
                    spaceVertical100,
                    CustomImageLoadWidget(
                      imageUrl: AppImages.instance.comingSoon,
                      imageColor: AppColors.instance.white,
                    ),
                  ],
                  if (context.read<HomeBloc>().imgList.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          padding: const EdgeInsets.only(left: 15),
                          child: Visibility(
                            visible: context.read<HomeBloc>().isQuizStarted,
                            child: CustomImageLoadWidget(
                              imageUrl: AppImages.instance.refresh,
                              height: 40,
                              width: 40,
                              onClick: () {
                                context.read<HomeBloc>().startQuiz();
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 67,
                            width: 67,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.instance.white,
                            ),
                            child: Center(
                              child: StreamBuilder<String>(
                                stream: context
                                    .read<HomeBloc>()
                                    .timerUpdateStream
                                    .stream,
                                initialData: "0:00",
                                builder: (context, snapshot) {
                                  return Text(
                                    '${snapshot.data}',
                                    style: TextStyle(
                                      color: AppColors.instance.black,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        CustomButtonWidget(
                          title: "Next\nQuiz",
                          width: 60,
                          height: 40,
                          textSize: 12,
                          textColor: AppColors.instance.white,
                          backgroundColor: AppColors.instance.appColor,
                          onPressed: () {
                            context.read<HomeBloc>().nextQuiz();
                          },
                        ),
                        spaceHorizontal10,
                      ],
                    ),
                    CarouselSlider(
                      carouselController:
                          context.read<HomeBloc>().carouselController,
                      options: CarouselOptions(
                        enlargeCenterPage: false,
                        aspectRatio: 1.22,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          context.read<HomeBloc>().pageIndex = index;
                          context.read<HomeBloc>().selectedOption = "";
                          setState(() {});
                        },
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                      ),
                      items: context
                          .read<HomeBloc>()
                          .imgList
                          .map((item) => HomeSliderView(
                                item,
                                onClick: () {
                                  context.read<HomeBloc>().viewImage(
                                      item.imageUrl,
                                      item.questionTitle,
                                      item.questionDescription);
                                },
                              ))
                          .toList(),
                    ),
                    spaceVertical10,
                    DotsIndicator(
                      dotsCount: context.read<HomeBloc>().imgList.isEmpty
                          ? 1
                          : context.read<HomeBloc>().imgList.length,
                      position: context.read<HomeBloc>().pageIndex,
                      decorator: DotsDecorator(
                        activeSize: const Size(60, 5),
                        size: const Size(35, 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        activeColor: AppColors.instance.appColor,
                        color: AppColors.instance.white,
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    if (!context.read<HomeBloc>().isQuizStarted) ...[
                      spaceVertical50,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButtonWidget(
                          title: "Start Quiz",
                          textColor: AppColors.instance.white,
                          backgroundColor: AppColors.instance.buttonColor1,
                          onPressed: () {
                            context.read<HomeBloc>().createQuiz();
                            setState(() {});
                          },
                        ),
                      )
                    ],
                    if (context.read<HomeBloc>().isQuizStarted) ...[
                      spaceVertical20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButtonWidget(
                                title: context
                                    .read<HomeBloc>()
                                    .imgList[context.read<HomeBloc>().pageIndex]
                                    .options![0],
                                textColor: AppColors.instance.white,
                                backgroundColor:
                                    context.read<HomeBloc>().selectedOption ==
                                            context
                                                .read<HomeBloc>()
                                                .imgList[context
                                                    .read<HomeBloc>()
                                                    .pageIndex]
                                                .options![0]
                                        ? AppColors.instance.buttonColor1
                                        : AppColors.instance.transparent,
                                borderColor:
                                    context.read<HomeBloc>().selectedOption ==
                                            context
                                                .read<HomeBloc>()
                                                .imgList[context
                                                    .read<HomeBloc>()
                                                    .pageIndex]
                                                .options![0]
                                        ? AppColors.instance.white
                                        : AppColors.instance.lightGray,
                                onPressed: () {
                                  context.read<HomeBloc>().selectedOption =
                                      context
                                          .read<HomeBloc>()
                                          .imgList[context
                                              .read<HomeBloc>()
                                              .pageIndex]
                                          .options![0];
                                  setState(() {});
                                },
                              ),
                            ),
                            spaceHorizontal10,
                            Expanded(
                              child: CustomButtonWidget(
                                title: context
                                    .read<HomeBloc>()
                                    .imgList[context.read<HomeBloc>().pageIndex]
                                    .options![1],
                                textColor: AppColors.instance.white,
                                backgroundColor:
                                    context.read<HomeBloc>().selectedOption ==
                                            context
                                                .read<HomeBloc>()
                                                .imgList[context
                                                    .read<HomeBloc>()
                                                    .pageIndex]
                                                .options![1]
                                        ? AppColors.instance.buttonColor1
                                        : AppColors.instance.transparent,
                                borderColor:
                                    context.read<HomeBloc>().selectedOption ==
                                            context
                                                .read<HomeBloc>()
                                                .imgList[context
                                                    .read<HomeBloc>()
                                                    .pageIndex]
                                                .options![1]
                                        ? AppColors.instance.white
                                        : AppColors.instance.lightGray,
                                onPressed: () {
                                  context.read<HomeBloc>().selectedOption =
                                      context
                                          .read<HomeBloc>()
                                          .imgList[context
                                              .read<HomeBloc>()
                                              .pageIndex]
                                          .options![1];
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceVertical35,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButtonWidget(
                          title: "Next",
                          textColor: AppColors.instance.white,
                          onPressed: () {
                            context.read<HomeBloc>().submitAnswer();
                          },
                        ),
                      )
                    ],
                  ],
                  if (context.read<HomeBloc>().mListLeader.isNotEmpty) ...[
                    spaceVertical20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomHeaderWidget(
                        "Best Players",
                        titleColor: AppColors.instance.white,
                        textSize: 20,
                      ),
                    ),
                    spaceVertical10,
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var obj = context.read<HomeBloc>().mListLeader[index];
                          return Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 150,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageLoadWidget(
                                        imageUrl: "${obj.profileImage}",
                                        height: 70,
                                        width: 70,
                                        borderRadius: 50,
                                      ),
                                      spaceVertical10,
                                      CustomSubHeaderWidget(
                                        "${obj.playerName}",
                                        titleSize: 16,
                                        maxLines: 2,
                                        ellipsis: TextOverflow.ellipsis,
                                      ),
                                      spaceVertical10,
                                      Container(
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.instance.appColor,
                                        ),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomImageLoadWidget(
                                              imageUrl: AppImages
                                                  .instance.iconDiamond,
                                              height: 15,
                                              width: 15,
                                              imageColor:
                                                  AppColors.instance.white,
                                            ),
                                            spaceHorizontal5,
                                            CustomSubHeaderWidget(
                                              "${obj.totalPointsEarned ?? 0}",
                                              textColor:
                                                  AppColors.instance.white,
                                              fontWeight: FontWeight.w500,
                                              maxLines: 1,
                                              ellipsis: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: context.read<HomeBloc>().mListLeader.length,
                      ),
                    ),
                  ],
                  if (context
                      .read<HomeBloc>()
                      .mListUpcomingQuiz
                      .isNotEmpty) ...[
                    spaceVertical20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomHeaderWidget(
                        "Upcoming Quiz",
                        titleColor: AppColors.instance.white,
                        textSize: 20,
                      ),
                    ),
                    spaceVertical10,
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var obj =
                              context.read<HomeBloc>().mListUpcomingQuiz[index];
                          return ItemUpcomingQuizView(
                            obj: obj,
                            index: index,
                            onClick: () {
                              context.read<HomeBloc>().playUpcomingQuiz(
                                  obj.quizId, true, obj.timeToFinish);
                            },
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            context.read<HomeBloc>().mListUpcomingQuiz.length,
                      ),
                    ),
                    spaceVertical20,
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
