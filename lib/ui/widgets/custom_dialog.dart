import 'package:realorfake/ui/widgets/widgets.dart';

class CustomDialog extends StatelessWidget {
  final String? message;
  final String? title;
  final String? cancelButtonText;
  final Function? cancelButtonCallback;
  final Function? okButtonCallback;
  final String? okButtonText;
  final TextAlign? textAlign;
  final String? imageSuccess;
  final bool? isShowSuccessImage;

  const CustomDialog({
    super.key,
    this.message,
    this.title,
    this.cancelButtonCallback,
    this.cancelButtonText,
    this.textAlign,
    this.imageSuccess,
    this.okButtonCallback,
    this.okButtonText,
    this.isShowSuccessImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isShowSuccessImage ?? true)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomImageLoadWidget(
                imageUrl:
                    imageSuccess ?? AppImages.instance.rightGreenTickCircle,
                height: 75,
                width: 75,
              ),
            ),
          if (title != null) ...[
            CustomHeaderWidget(
              title ?? "",
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            spaceVertical5
          ],
          CustomHeaderWidget(
            message ?? "",
            fontWeight: FontWeight.w400,
            maxLines: 20,
            textAlign: textAlign ?? TextAlign.center,
            ellipsis: TextOverflow.ellipsis,
            titleColor: AppColors.instance.hintColor,
            textSize: 16,
          ),
          spaceVertical20,
          CustomButtonWidget(
            title: okButtonText ?? "Okay",
            textSize: 16,
            height: 48,
            textColor: AppColors.instance.white,
            backgroundColor: AppColors.instance.appColor,
            onPressed: () {
              context.pop();
              if (okButtonCallback != null) {
                okButtonCallback!();
              }
            },
          ),
          if (cancelButtonText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomButtonWidget(
                title: cancelButtonText ?? "Cancel",
                textSize: 16,
                height: 48,
                backgroundColor: AppColors.instance.white,
                borderColor: AppColors.instance.appColor,
                textColor: AppColors.instance.appColor,
                onPressed: () {
                  context.pop();
                  if (cancelButtonCallback != null) {
                    cancelButtonCallback!();
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
