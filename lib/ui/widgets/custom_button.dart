import 'package:realorfake/ui/widgets/widgets.dart';

class CustomButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Function() onPressed;
  final String title;
  final double? cornerRadius;
  final double? cornerRadiusLeftTop;
  final double? cornerRadiusLeftBottom;
  final double? cornerRadiusRightTop;
  final double? cornerRadiusRightBottom;
  final IconData? icon;
  final IconData? iconLeft;
  final String? leftImageAsset;
  final Color? iconColor;
  final Color? leftImageAssetColor;
  final double? iconSize;
  final double? leftImageAssetHeight;
  final double? leftImageAssetWidth;
  final double? leftImageAssetLeftGap;
  final double? leftImageAssetGap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final double? textLeftPadding;
  final Color? borderColor;
  final MainAxisAlignment? mainAxisAlignment;
  final bool? isDisable;
  final TextAlign? textAlign;
  final bool? isBoxShadow;

  final String? rightImageAsset;
  final Color? rightImageAssetColor;
  final double? rightImageAssetHeight;
  final double? rightImageAssetWidth;
  final double? rightImageAssetLeftGap;
  final double? rightImageAssetGap;

  const CustomButtonWidget({
    super.key,
    this.width,
    this.leftImageAsset,
    this.leftImageAssetHeight,
    this.leftImageAssetColor,
    this.leftImageAssetLeftGap,
    this.leftImageAssetGap,
    this.leftImageAssetWidth,
    this.height,
    this.textAlign,
    this.cornerRadiusLeftTop,
    this.cornerRadiusLeftBottom,
    this.cornerRadiusRightTop,
    this.cornerRadiusRightBottom,
    required this.title,
    required this.onPressed,
    this.icon,
    this.textLeftPadding,
    this.iconLeft,
    this.cornerRadius,
    this.iconColor,
    this.fontWeight,
    this.mainAxisAlignment,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.borderColor,
    this.iconSize = 18.0,
    this.isDisable = false,
    this.isBoxShadow = false,
    this.rightImageAsset,
    this.rightImageAssetColor,
    this.rightImageAssetHeight,
    this.rightImageAssetWidth,
    this.rightImageAssetLeftGap,
    this.rightImageAssetGap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable == true ? null : onPressed,
      child: Container(
        width: width,
        height: height ?? 60,
        decoration: BoxDecoration(
            color: isDisable == true
                ? AppColors.instance.textEditBack
                : backgroundColor ?? AppColors.instance.appColor,
            border: Border.all(
                color: isDisable == true
                    ? AppColors.instance.textEditBack
                    : borderColor ?? AppColors.instance.appColor),
            borderRadius: cornerRadius != null
                ? BorderRadius.circular(
                    cornerRadius ?? AppSizes.instance.buttonRadius)
                : BorderRadius.only(
                    topLeft: Radius.circular(
                        cornerRadiusLeftTop ?? AppSizes.instance.buttonRadius),
                    topRight: Radius.circular(
                        cornerRadiusRightTop ?? AppSizes.instance.buttonRadius),
                    bottomLeft: Radius.circular(cornerRadiusLeftBottom ??
                        AppSizes.instance.buttonRadius),
                    bottomRight: Radius.circular(cornerRadiusRightBottom ??
                        AppSizes.instance.buttonRadius),
                  ),
            boxShadow: isBoxShadow == true
                ? [
                    BoxShadow(
                        color: isDisable == true
                            ? AppColors.instance.darkGray.withOpacity(0.3)
                            : backgroundColor != null
                                ? backgroundColor!.withOpacity(0.3)
                                : AppColors.instance.appColor.withOpacity(0.3),
                        blurRadius: 4.0,
                        offset: const Offset(0.0, 5.0)),
                  ]
                : []),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (leftImageAsset != null)
              Padding(
                padding: EdgeInsets.only(
                    right: leftImageAssetGap ?? 8,
                    left: leftImageAssetLeftGap ?? 0),
                child: Image.asset(
                  leftImageAsset!,
                  height: leftImageAssetHeight,
                  width: leftImageAssetWidth,
                  color: leftImageAssetColor,
                ),
              ),
            if (iconLeft != null) _buildLeftIcon(),
            Flexible(child: _buildTitle(context)),
            if (icon != null) _buildIcon(),
            if (rightImageAsset != null)
              Padding(
                padding: EdgeInsets.only(
                    right: rightImageAssetGap ?? 8,
                    left: rightImageAssetLeftGap ?? 0),
                child: Image.asset(
                  rightImageAsset!,
                  height: rightImageAssetHeight,
                  width: rightImageAssetWidth,
                  color: rightImageAssetColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: textLeftPadding ?? 0.0),
      child: Text(
        title,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: textColor ?? AppColors.instance.white,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontSize: textSize ?? 18),
      ),
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, right: 15.0, left: 10),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.instance.white,
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildLeftIcon() {
    if (iconLeft != null) {
      return Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Icon(
          iconLeft,
          size: iconSize,
          color: iconColor ?? AppColors.instance.white,
        ),
      );
    }
    return const SizedBox();
  }
}
