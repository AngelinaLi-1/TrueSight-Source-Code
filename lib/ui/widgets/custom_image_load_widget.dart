import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class CustomImageLoadWidget extends StatelessWidget {
  final String imageUrl;
  final String? imagePlaceHolder;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final double? borderWidth;
  final Color? imageColor;
  final Color? borderColor;
  final BoxFit? fit;
  final VoidCallback? onClick;
  final double? bottomBorderRadius;
  final bool? isDecoration;
  final Color? backColor;
  final bool isLoadFile;
  const CustomImageLoadWidget(
      {super.key,
      required this.imageUrl,
      this.imagePlaceHolder,
      this.height,
      this.width,
      this.borderRadiusTopLeft,
      this.borderRadiusTopRight,
      this.borderRadius,
      this.imageColor,
      this.borderWidth,
      this.borderColor,
      this.fit,
      this.onClick,
      this.bottomBorderRadius,
      this.isDecoration = false,
      this.isLoadFile = false,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    if (isLoadFile) {
      return InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backColor ?? Colors.transparent,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: fit,
            ),
            borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(borderRadiusTopLeft ?? borderRadius ?? 0),
                topRight:
                    Radius.circular(borderRadiusTopRight ?? borderRadius ?? 0),
                bottomLeft: Radius.circular(borderRadius ?? 0),
                bottomRight: Radius.circular(borderRadius ?? 0)),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(borderRadiusTopLeft ?? borderRadius ?? 0),
                topRight:
                    Radius.circular(borderRadiusTopRight ?? borderRadius ?? 0),
                bottomLeft: Radius.circular(borderRadius ?? 0),
                bottomRight: Radius.circular(borderRadius ?? 0)),
            child: Image.file(
              File(imageUrl),
              fit: fit,
              height: height,
              width: width,
              color: imageColor,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                    imagePlaceHolder ?? AppImages.instance.imagePlaceHolder);
              },
            ),
          ),
        ),
      );
    }
    if (imageUrl.startsWith('http')) {
      return InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backColor ?? Colors.transparent,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: fit,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            border: isDecoration!
                ? Border(
                    bottom: BorderSide(
                      color: borderColor ?? AppColors.instance.borderColor3,
                      width: borderWidth ?? 0,
                    ),
                  )
                : Border.all(
                    color: borderColor ?? AppColors.instance.borderColor3,
                    width: borderWidth ?? 0,
                  ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              height: height,
              width: width,
              placeholder: (context, url) => Platform.isAndroid
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(strokeCap: StrokeCap.round),
                      ],
                    )
                  : const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                  imagePlaceHolder ?? AppImages.instance.imagePlaceHolder),
            ),
          ),
        ),
      );
    } else if (imageUrl.startsWith('assets')) {
      return InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backColor ?? Colors.transparent,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: fit,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            child: Image.asset(
              imageUrl,
              fit: fit,
              height: height,
              width: width,
              color: imageColor,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                    imagePlaceHolder ?? AppImages.instance.imagePlaceHolder);
              },
            ),
          ),
        ),
      );
    } else if (imageUrl == "null" || imageUrl == "") {
      return InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backColor ?? Colors.transparent,
            image: DecorationImage(
              image: AssetImage(
                imagePlaceHolder ?? AppImages.instance.imagePlaceHolder,
              ),
              fit: fit,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            border: Border.all(
              color: borderColor ?? AppColors.instance.borderColor3,
              width: borderWidth ?? 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            child: Image.asset(
              imagePlaceHolder ?? AppImages.instance.imagePlaceHolder,
              fit: fit,
              height: height,
              width: width,
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backColor ?? Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              imagePlaceHolder ?? AppImages.instance.imagePlaceHolder,
            ),
            fit: fit,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
          border: Border.all(
            color: borderColor ?? AppColors.instance.borderColor3,
            width: borderWidth ?? 0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: Image.memory(
            const Base64Decoder().convert(imageUrl),
            fit: fit,
            height: height,
            width: width,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Image.asset(
                  imagePlaceHolder ?? AppImages.instance.imagePlaceHolder);
            },
          ),
        ),
      ),
    );
  }
}
