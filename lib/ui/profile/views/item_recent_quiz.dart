import 'package:realorfake/data/responses/history_model.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ItemRecentQuizView extends StatelessWidget {
  final HistoryModel obj;
  const ItemRecentQuizView({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: AppColors.instance.appColorBottom,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        minLeadingWidth: 10,
        title: Row(
          children: [
            CustomImageLoadWidget(
              imageUrl: AppImages.instance.bottomHistory,
              height: 50,
              width: 50,
              borderRadius: 50,
              backColor: AppColors.instance.white,
            ),
            spaceHorizontal10,
            Expanded(
              child: Column(
                children: [
                  CustomHeaderWidget(
                    "${obj.quizName}",
                    maxLines: 1,
                    titleColor: AppColors.instance.white,
                    ellipsis: TextOverflow.ellipsis,
                  ),
                  CustomHeaderWidget(
                    "Time Taken: ${convertSecondToMin1(obj.timeTaken)}",
                    maxLines: 1,
                    titleColor: AppColors.instance.green,
                    ellipsis: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 70,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: AppColors.instance.white,
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageLoadWidget(
                imageUrl: AppImages.instance.iconDiamond,
                height: 15,
                width: 15,
              ),
              spaceHorizontal5,
              CustomSubHeaderWidget(
                "${obj.totalPointsEarned}",
                textColor: AppColors.instance.appColor,
                fontWeight: FontWeight.w500,
                maxLines: 1,
                ellipsis: TextOverflow.ellipsis,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
