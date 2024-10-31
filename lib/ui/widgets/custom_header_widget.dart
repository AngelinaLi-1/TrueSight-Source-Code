import 'package:realorfake/ui/widgets/widgets.dart';

class CustomHeaderWidget extends StatelessWidget {
  final double? width;
  final String? title;
  final TextStyle? style;
  final double? textSize;
  final double? wordSpacing;
  final int? maxLines;
  final TextOverflow? ellipsis;
  final FontWeight? fontWeight;
  final String? imageRightAsset;
  final double? imageRightHeight;
  final double? imageRightWidth;
  final Color? imageRightColor;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextAlign? textAlign;
  final double? imageGap;
  final Color? titleColor;
  final String? imageLeftAsset;
  final double? imageLeftHeight;
  final double? imageLeftWidth;
  final Color? imageLeftColor;
  final String? fontFamily;
  final double? rightImageGap;
  final VoidCallback? onClick;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final VoidCallback? onClickRightImageAsset;
  final double? lineHeight;

  const CustomHeaderWidget(this.title,
      {super.key,
      this.width,
      this.style,
      this.textSize,
      this.mainAxisAlignment,
      this.imageRightWidth,
      this.imageRightHeight,
      this.wordSpacing = 0,
      this.imageRightColor,
      this.maxLines,
      this.ellipsis,
      this.textAlign,
      this.imageRightAsset,
      this.crossAxisAlignment,
      this.fontWeight,
      this.imageGap,
      this.titleColor,
      this.imageLeftAsset,
      this.imageLeftHeight,
      this.imageLeftWidth,
      this.imageLeftColor,
      this.fontFamily,
      this.rightImageGap,
      this.onClick,
      this.decoration,
      this.onClickRightImageAsset,
      this.decorationColor,
      this.lineHeight});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onClick,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            if (imageLeftAsset != null)
              Padding(
                  padding: EdgeInsets.only(
                      left: imageGap ?? 5, right: rightImageGap ?? 5),
                  child: CustomImageLoadWidget(
                    imageUrl: imageLeftAsset!,
                    width: imageLeftWidth ?? 14,
                    height: imageLeftHeight ?? 18,
                    borderColor: AppColors.instance.transparent,
                    imageColor: imageLeftColor,
                  )),
            Flexible(
              child: Text(
                title ?? "",
                maxLines: maxLines,
                overflow: ellipsis,
                textAlign: textAlign,
                style: style ??
                    theme.textTheme.titleSmall!.copyWith(
                      fontSize: textSize,
                      height: lineHeight ?? 1.5,
                      fontWeight: fontWeight,
                      wordSpacing: wordSpacing,
                      fontFamily: fontFamily,
                      decoration: decoration ?? TextDecoration.none,
                      decorationColor:
                          decorationColor ?? AppColors.instance.textColor1,
                      color: titleColor ?? AppColors.instance.textColor,
                    ),
              ),
            ),
            if (imageRightAsset != null)
              GestureDetector(
                onTap: onClickRightImageAsset,
                child: Padding(
                  padding: EdgeInsets.only(left: imageGap ?? 5),
                  child: CustomImageLoadWidget(
                    imageUrl: imageRightAsset!,
                    width: imageRightWidth ?? 16,
                    height: imageRightHeight ?? 16,
                    imageColor: imageRightColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
