import 'package:realorfake/data/responses/question_model.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HomeSliderView extends StatelessWidget {
  final QuestionsModel item;
  final VoidCallback? onClick;
  const HomeSliderView(this.item, {super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.only(left: 7, right: 7),
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            children: [
              CustomImageLoadWidget(
                imageUrl: "${item.imageUrl}",
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
                borderRadius: 20,
              ),
              spaceVertical5,
              CustomHeaderWidget(
                item.questionTitle,
                titleColor: AppColors.instance.white,
                maxLines: 1,
                ellipsis: TextOverflow.ellipsis,
              ),
              CustomHeaderWidget(
                item.questionDescription,
                titleColor: AppColors.instance.white,
                fontWeight: FontWeight.w400,
                textSize: 14,
                maxLines: 1,
                ellipsis: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
