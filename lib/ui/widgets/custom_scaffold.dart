import 'package:realorfake/ui/widgets/widgets.dart';

class CustomScaffold extends StatelessWidget {
  final Color? background;
  final IconData? iconBack;
  final Color? backIconColor;
  final Color? backgroundAppbar;
  final Color? backgroundStatusBar;
  final String? title;
  final String? rightTitleText;
  final Color? rightTitleTextColor;
  final FontWeight? titleFontWeight;
  final double? titleSize;
  final String? subTitle;
  final String? subSubTitle;
  final Color? titleColor;
  final Widget body;
  final double elevation;
  final double? titleSpacing;
  final double? subTitleSize;
  final double? subSubTitleSize;
  final String? subSubLeftImage;
  final int? subTitleMaxLine;
  final int? subSubTitleMaxLine;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final List<Widget>? actionBars;
  final double? sidePadding;
  final double? toolbarHeight;
  final bool? isShowAppBar;
  final bool? isShowBackButton;
  final bool? disableSafeAreaBottom;
  final bool? disableSafeAreaTop;
  final bool? resizeToAvoidBottomInset;
  final VoidCallback? onBackButtonClick;
  final VoidCallback? onClickTitle;
  final String? imageAsset;
  final double? imageAssetHeight;
  final double? imageAssetWidth;
  final bool? isShowAppBarBorder;
  final String? titleRightImageAssets;
  final double? titleRightImageHeight;
  final double? titleRightImageWidth;
  final double? titleRightImageGap;
  final FontWeight? subTitleFontWeight;
  final Color? subTitleColor;

  const CustomScaffold(
      {super.key,
      this.background,
      this.backgroundStatusBar,
      this.iconBack,
      this.backgroundAppbar,
      this.disableSafeAreaBottom,
      this.disableSafeAreaTop,
      this.title = "",
      this.rightTitleText,
      this.rightTitleTextColor,
      this.onClickTitle,
      this.subTitle,
      this.titleSize,
      this.titleFontWeight,
      this.titleSpacing,
      this.subSubLeftImage,
      this.subSubTitleSize,
      this.onBackButtonClick,
      this.subTitleSize,
      this.subTitleMaxLine,
      this.subSubTitle,
      this.subSubTitleMaxLine,
      this.toolbarHeight,
      this.isShowBackButton = true,
      this.backIconColor,
      this.isShowAppBar = true,
      this.resizeToAvoidBottomInset = false,
      this.titleColor,
      this.elevation = 0,
      this.bottomNavigationBar,
      this.floatingActionButton,
      required this.body,
      this.actionBars,
      this.sidePadding,
      this.imageAsset,
      this.imageAssetHeight,
      this.imageAssetWidth,
      this.isShowAppBarBorder,
      this.titleRightImageAssets,
      this.titleRightImageHeight,
      this.titleRightImageWidth,
      this.titleRightImageGap,
      this.subTitleFontWeight,
      this.subTitleColor});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: isShowAppBar == true
          ? AppBar(
              toolbarHeight: toolbarHeight,
              backgroundColor: backgroundAppbar,
              elevation: elevation,
              scrolledUnderElevation: elevation,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: isShowAppBarBorder == true
                      ? Divider(
                          height: 1, color: AppColors.instance.borderColor2)
                      : const SizedBox()),
              leading: isShowBackButton == true
                  ? iconBack == null
                      ? IconButton(
                          onPressed: onBackButtonClick ??
                              () {
                                Navigator.pop(context);
                              },
                          icon: Image.asset(
                            imageAsset ?? AppImages.instance.iconBack,
                            height: imageAssetHeight ?? 12,
                            width: imageAssetWidth ?? 20,
                            fit: BoxFit.fill,
                            color: backIconColor ?? AppColors.instance.white,
                          ),
                        )
                      : Icon(
                          iconBack,
                          size: 30,
                        )
                  : null,
              titleSpacing: titleSpacing ?? 0,
              iconTheme: IconThemeData(
                  color: backIconColor ?? AppColors.instance.black),
              title: GestureDetector(
                onTap: onClickTitle,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "$title",
                            maxLines: 2,
                            style: theme.textTheme.titleMedium!
                                .copyWith(
                                  color: titleColor,
                                  fontSize: titleSize,
                                  height: 1.2,
                                  fontWeight: titleFontWeight,
                                  overflow: TextOverflow.ellipsis,
                                )
                                .apply(),
                          ),
                        ),
                        SizedBox(width: titleRightImageGap ?? 5),
                        if (titleRightImageAssets != null)
                          Image.asset(
                            titleRightImageAssets!,
                            height: titleRightImageHeight ?? 16,
                            width: titleRightImageWidth ?? 16,
                          ),
                        if (rightTitleText != null)
                          Flexible(
                            child: Text(
                              "$rightTitleText",
                              maxLines: 1,
                              style: theme.textTheme.titleMedium!
                                  .copyWith(
                                    color: rightTitleTextColor,
                                    fontSize: titleSize,
                                    fontWeight: titleFontWeight,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                  .apply(),
                            ),
                          ),
                      ],
                    ),
                    if (subTitle != null)
                      Text(
                        "$subTitle",
                        maxLines: subTitleMaxLine ?? 2,
                        style: theme.textTheme.labelMedium!
                            .copyWith(
                                fontWeight:
                                    subTitleFontWeight ?? FontWeight.w400,
                                fontSize: subTitleSize ?? 14,
                                color: subTitleColor)
                            .apply(),
                      ),
                    if (subSubTitle != null)
                      RichText(
                        maxLines: subSubTitleMaxLine ?? 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            if (subSubLeftImage != null)
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, bottom: 3),
                                  child: Image.asset(
                                    subSubLeftImage!,
                                    height: 9,
                                    width: 9,
                                    color: AppColors.instance.appColor,
                                  ),
                                ),
                              ),
                            TextSpan(
                              text: "$subSubTitle",
                              style: theme.textTheme.labelMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: subSubTitleSize ?? 14,
                                  )
                                  .apply(),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              centerTitle: false,
              actions: actionBars,
            )
          : null,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sidePadding ?? 15),
          child: Container(
            color: backgroundStatusBar ?? AppColors.instance.white,
            child: SafeArea(
              left: false,
              right: false,
              top: disableSafeAreaTop ?? true,
              bottom: disableSafeAreaBottom ?? true,
              child: body,
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
