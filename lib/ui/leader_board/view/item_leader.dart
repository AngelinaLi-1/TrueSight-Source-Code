import 'package:realorfake/data/responses/leader_board_model.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ItemLeaderView extends StatelessWidget {
  final LeaderBoardModel obj;
  final int index;
  final bool isUser;
  const ItemLeaderView({
    super.key,
    required this.obj,
    required this.index,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: isUser
            ? AppColors.instance.appColorBottom
            : AppColors.instance.appColor,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        leading: isUser
            ? null
            : CustomSubHeaderWidget(
                "${index + 1}",
                textColor: AppColors.instance.white,
              ),
        minLeadingWidth: 10,
        title: Row(
          children: [
            CustomImageLoadWidget(
              imageUrl: "${obj.profileImage}",
              height: 50,
              width: 50,
              borderRadius: 50,
            ),
            spaceHorizontal10,
            Expanded(
              child: Column(
                children: [
                  CustomHeaderWidget(
                    "${obj.playerName}",
                    maxLines: 1,
                    titleColor: AppColors.instance.white,
                    ellipsis: TextOverflow.ellipsis,
                  ),
                  if (isUser)
                    CustomHeaderWidget(
                      obj.message ?? "",
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
                "${obj.totalPointsEarned ?? 0}",
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
