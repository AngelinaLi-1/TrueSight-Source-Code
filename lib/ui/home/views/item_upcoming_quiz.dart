import 'package:realorfake/data/responses/upcoming_quiz_model.dart';
import 'package:realorfake/ui/home/views/quiz_count_down_timer.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ItemUpcomingQuizView extends StatefulWidget {
  final int index;
  final UpcomingQuizModel obj;
  final VoidCallback onClick;

  const ItemUpcomingQuizView(
      {super.key,
      required this.obj,
      required this.index,
      required this.onClick});

  @override
  State<ItemUpcomingQuizView> createState() => _ItemUpcomingQuizViewState();
}

class _ItemUpcomingQuizViewState extends State<ItemUpcomingQuizView> {
  bool isTimeCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: AppSizes.instance.getScreenWidth(context) * 0.9,
      child: Card(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      height: 40,
                      width: 60,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: AppColors.instance.blue,
                      ),
                      child: Center(
                        child: CustomSubHeaderWidget(
                          formatDate(widget.obj.startDate),
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.instance.white,
                        ),
                      ),
                    ),
                  ),
                  QuizCountdownTimerView(
                    startTime: widget.obj.startTime ?? "",
                    startDate: widget.obj.startDate.toString(),
                    onClickPlay: widget.onClick,
                    onTimerComplete: () {
                      isTimeCompleted = true;
                    },
                  )
                ],
              ),
            ),
            spaceVertical10,
            CustomHeaderWidget(
              "${widget.obj.title}",
              textSize: 14,
              textAlign: TextAlign.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            spaceVertical10,
            CustomImageLoadWidget(
              imageUrl: AppImages.instance.bottomHistory,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
              borderRadius: 50,
              imageColor: AppColors.instance.appColorBottom,
              backColor: AppColors.instance.appColorBottom.withOpacity(0.3),
            ),
            spaceVertical10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Max Time: ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: convertSecondToMin1(widget.obj.timeToFinish),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Max Ques: ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: '${(widget.obj.questions ?? []).length}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            spaceVertical15,
          ],
        ),
      ),
    );
  }
}
