import 'package:dotted_border/dotted_border.dart';
import 'package:lottie/lottie.dart';
import 'package:realorfake/ui/result_summary/result_summary_bloc.dart';
import 'package:realorfake/ui/result_summary/result_summary_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ResultSummaryMobScreen extends StatefulWidget {
  const ResultSummaryMobScreen({super.key});

  @override
  State<ResultSummaryMobScreen> createState() => _ResultSummaryMobScreenState();
}

class _ResultSummaryMobScreenState extends State<ResultSummaryMobScreen> {
  int index = 0;
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
        title: "Result Summary",
        body: BlocBuilder<ResultSummaryBloc, ResultSummaryState>(
          builder: (context, state) {
            if (state is ResultSummaryLoadingState) {
              return const CustomLoadingWidget();
            }
            if (state is ResultSummaryLoadedState) {
              var obj = state.obj;
              var isScoreGreaterThen0 = (obj.totalPointsEarned ?? 0) > 0;
              return Stack(
                children: [
                  Visibility(
                      visible: isScoreGreaterThen0,
                      child: Lottie.asset(AppImages.instance.congratulations)),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          spaceVertical10,
                          DottedBorder(
                            borderType: BorderType.Circle,
                            dashPattern: const [7, 3],
                            color: AppColors.instance.yellow,
                            strokeWidth: 2,
                            child: CustomImageLoadWidget(
                              imageUrl: context.read<ResultSummaryBloc>().image,
                              height: 110,
                              width: 110,
                              borderRadius: 100,
                            ),
                          ),
                          spaceVertical15,
                          CustomSubHeaderWidget(
                            context.read<ResultSummaryBloc>().name,
                            textColor: AppColors.instance.white,
                            fontWeight: FontWeight.w500,
                            titleSize: 20,
                            textAlign: TextAlign.center,
                          ),
                          spaceVertical15,
                          CustomSubHeaderWidget(
                            isScoreGreaterThen0
                                ? "Congratulation!"
                                : "Unfortunately, your score is 0. Better luck next time!",
                            textColor: AppColors.instance.buttonColor1,
                            fontWeight: FontWeight.w700,
                            titleSize: 24,
                            textAlign: TextAlign.center,
                          ),
                          spaceVertical10,
                          CustomSubHeaderWidget(
                            "Your Score",
                            textColor: AppColors.instance.white,
                            fontWeight: FontWeight.w500,
                            titleSize: 20,
                            textAlign: TextAlign.center,
                          ),
                          spaceVertical10,
                          isScoreGreaterThen0
                              ? RotatedBox(
                                  quarterTurns: 2,
                                  child: CustomImageLoadWidget(
                                    imageUrl: AppImages.instance.excellence,
                                    height: 100,
                                    width: 50,
                                    imageColor: AppColors.instance.buttonColor1,
                                  ),
                                )
                              : CustomImageLoadWidget(
                                  imageUrl: AppImages.instance.saidGif,
                                  height: 100,
                                  width: 50,
                                ),
                          spaceVertical10,
                          CustomSubHeaderWidget(
                            "${obj.totalPointsEarned}/${obj.totalPoints}",
                            textColor: AppColors.instance.green,
                            fontWeight: FontWeight.w500,
                            titleSize: 24,
                            textAlign: TextAlign.center,
                          ),
                          spaceVertical5,
                          CustomSubHeaderWidget(
                            "${context.read<ResultSummaryBloc>().getCorrectAnswerCount()}/${(obj.questions ?? []).length} Questions",
                            textColor: AppColors.instance.white,
                            titleSize: 16,
                            textAlign: TextAlign.center,
                          ),
                          spaceVertical15,
                          LinearProgressIndicator(
                            value: (obj.totalPointsEarned ?? 0) /
                                (obj.totalPoints ?? 0),
                            minHeight: 15,
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.instance.blue.withAlpha(100),
                            backgroundColor:
                                AppColors.instance.blue.withAlpha(50),
                          ),
                          spaceVertical10,
                          Visibility(
                            visible: false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageLoadWidget(
                                  imageUrl: AppImages.instance.watch,
                                  height: 15,
                                  width: 15,
                                  imageColor: AppColors.instance.lightGray,
                                ),
                                spaceHorizontal5,
                                CustomSubHeaderWidget(
                                  "20s",
                                  textColor: AppColors.instance.lightGray,
                                ),
                              ],
                            ),
                          ),
                          spaceVertical50,
                          CustomButtonWidget(
                            title: isScoreGreaterThen0 ? "Close" : "Try Again",
                            onPressed: () {
                              context.pop();
                            },
                          ),
                          spaceVertical15,
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomSubHeaderWidget(
                              "Given Answer",
                              textColor: AppColors.instance.white,
                              titleSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          spaceVertical15,
                          ListView.builder(
                            itemCount: obj.questions?.length ?? 0,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var obj1 = obj.questions![index];
                              return SizedBox(
                                height: 300,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomImageLoadWidget(
                                      imageUrl:
                                          obj.imgList[index].imageUrl ?? "",
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      height: 200,
                                      borderRadius: 20,
                                      onClick: () {
                                        context
                                            .read<ResultSummaryBloc>()
                                            .viewImage(
                                                obj.imgList[index].imageUrl);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomButtonWidget(
                                              title: obj.imgList[index]
                                                      .options?[0] ??
                                                  "",
                                              backgroundColor: context
                                                  .read<ResultSummaryBloc>()
                                                  .markRightWrongColor(
                                                      obj.imgList[index]
                                                          .options?[0],
                                                      obj1.correctAnswer,
                                                      obj1.givenAnswer),
                                              borderColor:
                                                  AppColors.instance.white,
                                              onPressed: () {},
                                            ),
                                          ),
                                          spaceHorizontal10,
                                          Expanded(
                                            child: CustomButtonWidget(
                                              title: obj.imgList[index]
                                                      .options?[1] ??
                                                  "",
                                              textColor:
                                                  AppColors.instance.white,
                                              backgroundColor: context
                                                  .read<ResultSummaryBloc>()
                                                  .markRightWrongColor(
                                                      obj.imgList[index]
                                                          .options?[1],
                                                      obj1.correctAnswer,
                                                      obj1.givenAnswer),
                                              borderColor:
                                                  AppColors.instance.white,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          spaceVertical10,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const CustomLoadingWidget();
          },
        ),
      ),
    );
  }
}
