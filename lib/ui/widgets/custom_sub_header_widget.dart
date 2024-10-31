import 'package:realorfake/ui/widgets/widgets.dart';

class CustomSubHeaderWidget extends StatelessWidget {
  final String title;
  final double? titleSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextOverflow? ellipsis;
  final double? leftSize;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? lineSpacing;

  const CustomSubHeaderWidget(this.title,
      {super.key,
      this.titleSize,
      this.leftSize,
      this.textAlign,
      this.maxLines,
      this.wordSpacing,
      this.fontWeight,
      this.textColor,
      this.ellipsis,
      this.decoration,
      this.decorationColor,
      this.lineSpacing});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: ellipsis,
      style: theme.textTheme.labelMedium!.copyWith(
        color: textColor ?? AppColors.instance.hintColor,
        fontSize: titleSize,
        wordSpacing: wordSpacing ?? 0,
        height: lineSpacing ?? 1.3,
        fontWeight: fontWeight,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor ?? AppColors.instance.textColor1,
      ),
    );
  }
}
