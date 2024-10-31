import 'package:realorfake/ui/widgets/widgets.dart';

class ItemIntroWidget extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? subTitle;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageRightPadding;
  final VoidCallback onClick;
  const ItemIntroWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.imageWidth,
    this.imageHeight,
    this.imageRightPadding,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          spaceVertical45,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomHeaderWidget(
              title,
              textSize: 26,
              fontWeight: FontWeight.w600,
              titleColor: AppColors.instance.white,
              textAlign: TextAlign.center,
              mainAxisAlignment: MainAxisAlignment.center,
              lineHeight: 0,
            ),
          ),
          spaceVertical10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomHeaderWidget(
              subTitle!,
              fontWeight: FontWeight.w400,
              titleColor: AppColors.instance.white,
              maxLines: 2,
              textSize: 20,
              textAlign: TextAlign.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: imageRightPadding ?? 0, top: 50),
              child: CustomImageLoadWidget(
                imageUrl: "$imagePath",
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            child: CustomButtonWidget(
              title: "Let's get started",
              textSize: 20,
              cornerRadius: 20,
              textColor: AppColors.instance.appColor,
              backgroundColor: AppColors.instance.buttonColor,
              onPressed: onClick,
            ),
          ),
        ],
      ),
    );
  }
}
