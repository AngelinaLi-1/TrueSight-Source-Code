import 'package:flutter/services.dart';
import 'package:realorfake/ui/widgets/upper_case_text_formatter.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class CustomTextInputWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Color? labelTextColor;
  final String? filledLabelText;
  final String? labelBottomText;
  final String? suffixText;
  final FontWeight? suffixWeight;
  final double? suffixSize;
  final Color? suffixTextColor;
  final Color? suffixIconColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? suffixIconSize;
  final Color? labelBottomColor;
  final bool? isChecked;
  final String? leftImageAsset;
  final double? leftImageHeight;
  final double? leftImageWidth;
  final double? leftImageGap;
  final Color? leftImageColor;
  final IconData? suffixIcon;
  final int? maxLength;
  final bool? enabled;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final FocusNode? focusNode;
  final bool? isPassword;
  final Function(String text)? onValueChanged;
  final VoidCallback? onClick;
  final VoidCallback? onClickPrefix;
  final bool isAcceptNumber;
  final bool isAcceptDecimal;
  final Function(bool isFocus)? onFocusChange;
  final double? cornerRadius;
  final TextCapitalization? textCapitalization;
  final bool? verticalDivider;
  final double? verticalDividerWidth;
  final String? labelRightImageAsset;
  final double? labelRightImageHeight;
  final double? labelRightImageWidth;
  final double? labelRightImageGap;
  final String? rightImageAssetSuffix;
  final double? rightImageHeightSuffix;
  final double? rightImageWidthSuffix;
  final double? rightImageGapSuffix;
  final Color? rightImageColorSuffix;
  final double? height;
  final Alignment? alignment;
  final IconData? suffixLeftIcon;
  final Color? suffixLeftIconColor;
  final double? suffixLeftIconSize;
  final double? suffixLeftPadding;
  final String? subLabelText;
  final Color? subLabelTextColor;
  final VoidCallback? onClickSuffix;
  final VoidCallback? onClickRightImageAsset;
  final bool isSuffixLeftIcon;
  final bool isAcceptName;
  final bool isAcceptNumberAndName;
  final FontWeight? labelFontWeight;
  final bool isCapitalWhenType;
  final bool isLowerWhenType;
  final double? borderWeight;
  final bool isAcceptNumberAndNameOrUnderScore;

  const CustomTextInputWidget(
      {super.key,
      this.hintText,
      this.filledLabelText,
      this.labelBottomText,
      this.labelText,
      this.leftImageAsset,
      this.hintTextColor,
      this.leftImageColor,
      this.backgroundColor,
      this.leftImageHeight,
      this.leftImageGap,
      this.borderColor,
      this.leftImageWidth,
      this.isChecked = false,
      this.isPassword = false,
      this.onClickPrefix,
      this.cornerRadius,
      this.suffixText,
      this.suffixIconColor,
      this.suffixIconSize,
      this.suffixTextColor,
      this.suffixWeight,
      this.suffixSize,
      this.suffixIcon,
      this.controller,
      this.keyboard,
      this.focusNode,
      this.enabled,
      this.textCapitalization = TextCapitalization.words,
      this.onClickRightImageAsset,
      this.maxLength,
      this.labelBottomColor,
      this.onFocusChange,
      this.isAcceptNumber = false,
      this.isAcceptDecimal = false,
      this.isAcceptName = false,
      this.isAcceptNumberAndName = false,
      this.isCapitalWhenType = false,
      this.isLowerWhenType = false,
      this.onClick,
      this.onValueChanged,
      this.verticalDivider,
      this.verticalDividerWidth,
      this.labelTextColor,
      this.labelRightImageAsset,
      this.labelRightImageHeight,
      this.labelRightImageWidth,
      this.labelRightImageGap,
      this.rightImageAssetSuffix,
      this.rightImageHeightSuffix,
      this.rightImageWidthSuffix,
      this.rightImageGapSuffix,
      this.rightImageColorSuffix,
      this.height,
      this.alignment,
      this.suffixLeftIcon,
      this.suffixLeftIconColor,
      this.suffixLeftIconSize,
      this.suffixLeftPadding,
      this.subLabelText,
      this.subLabelTextColor,
      this.onClickSuffix,
      this.isSuffixLeftIcon = true,
      this.labelFontWeight,
      this.borderWeight,
      this.isAcceptNumberAndNameOrUnderScore = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        Text(
                          labelText!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: labelTextColor ??
                                      AppColors.instance.black,
                                  fontSize: 16,
                                  fontWeight:
                                      labelFontWeight ?? FontWeight.w400),
                        ),
                        labelRightImageAsset != null
                            ? GestureDetector(
                                onTap: onClickRightImageAsset,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Image.asset(
                                    labelRightImageAsset!,
                                    height: labelRightImageHeight ?? 16,
                                    width: labelRightImageWidth ?? 16,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  if (subLabelText != null)
                    Text(
                      subLabelText!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: subLabelTextColor ?? AppColors.instance.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                ],
              )
            : const SizedBox(),
        if (labelText != null) spaceVertical10,
        Container(
          height: height ?? 57,
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: borderColor ?? AppColors.instance.textEditBack,
                width: borderWeight ?? 1),
            borderRadius: BorderRadius.circular(cornerRadius ?? 10),
            color: backgroundColor ?? AppColors.instance.lightGrayUpload,
          ),
          child: InkWell(
            onTap: onClick,
            child: Row(
              children: [
                leftImageAsset != null
                    ? InkWell(
                        onTap: onClickPrefix,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Image.asset(
                            leftImageAsset!,
                            height: leftImageHeight ?? 16,
                            width: leftImageWidth ?? 16,
                            color: leftImageColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
                verticalDivider != null
                    ? VerticalDivider(
                        color: AppColors.instance.textEditBack,
                        width: verticalDividerWidth ?? 25,
                      )
                    : const SizedBox(),
                Flexible(
                  child: Align(
                    alignment: alignment ?? Alignment.center,
                    child: Focus(
                      onFocusChange: onFocusChange,
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.instance.black,
                          fontWeight: FontWeight.w400,
                        ),
                        textCapitalization: textCapitalization!,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(maxLength),
                          if (isAcceptDecimal)
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          if (isAcceptNumber)
                            FilteringTextInputFormatter.digitsOnly,
                          if (isAcceptNumberAndName)
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9]')),
                          if (isAcceptName)
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]')),
                          if (isCapitalWhenType) UpperCaseTextFormatter(),
                          if (isLowerWhenType) LowerCaseTextFormatter(),
                          if (isAcceptNumberAndNameOrUnderScore)
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9_]')),
                        ],
                        onChanged: (value) {
                          if (onValueChanged != null) onValueChanged!(value);
                        },
                        enabled: enabled,
                        controller: controller,
                        focusNode: focusNode,
                        keyboardType: keyboard,
                        obscureText: isPassword!,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: hintText,
                          // labelText: filledLabelText,
                          hintStyle: TextStyle(
                              color:
                                  hintTextColor ?? AppColors.instance.hintColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(
                              left: leftImageGap ?? 16.0,
                              bottom: 8.0,
                              top: 8.0,
                              right: 5.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                if (isSuffixLeftIcon)
                  InkWell(
                    onTap: onClickSuffix,
                    child: Row(
                      children: [
                        if (suffixLeftIcon != null)
                          Icon(
                            suffixLeftIcon,
                            color: suffixLeftIconColor ??
                                AppColors.instance.appColor,
                            size: suffixLeftIconSize ?? 17,
                          ),
                        suffixText != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: suffixLeftPadding ?? 12, right: 5),
                                child: Text(
                                  suffixText!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: suffixTextColor,
                                          fontWeight: suffixWeight,
                                          fontSize: suffixSize),
                                ),
                              )
                            : const SizedBox(),
                        if (suffixIcon != null)
                          Icon(
                            suffixIcon,
                            color:
                                suffixIconColor ?? AppColors.instance.appColor,
                            size: suffixIconSize ?? 17,
                          ),
                        if (rightImageAssetSuffix != null)
                          InkWell(
                            onTap: onClickSuffix,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: rightImageGapSuffix ?? 15),
                              child: CustomImageLoadWidget(
                                imageUrl: rightImageAssetSuffix!,
                                height: rightImageHeightSuffix ?? 16,
                                width: rightImageWidthSuffix ?? 16,
                                imageColor: rightImageColorSuffix,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (labelBottomText != null && labelBottomText != "")
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              labelBottomText!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: labelBottomColor ?? AppColors.instance.hintColor,
                  fontSize: 14),
            ),
          ),
      ],
    );
  }
}
