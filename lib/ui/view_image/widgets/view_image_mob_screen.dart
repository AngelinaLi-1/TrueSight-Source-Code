import 'package:dots_indicator/dots_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:realorfake/ui/view_image/view_image_bloc.dart';
import 'package:realorfake/ui/view_image/view_image_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ViewImageMobScreen extends StatefulWidget {
  const ViewImageMobScreen({super.key});

  @override
  State<ViewImageMobScreen> createState() => _ViewDocumentsMobScreenState();
}

class _ViewDocumentsMobScreenState extends State<ViewImageMobScreen> {
  int selectedIndex = 0;
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewImageBloc, ViewImageState>(
      builder: (context, state) {
        var imageList = context.read<ViewImageBloc>().mList;
        return CustomScaffold(
          isShowAppBar: false,
          background: AppColors.instance.black,
          backgroundStatusBar: AppColors.instance.black,
          sidePadding: 0,
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: AppColors.instance.white,
                    ),
                  ),
                  Expanded(
                    child: CustomSubHeaderWidget(
                      "${imageList[selectedIndex].imageTitle}",
                      textColor: AppColors.instance.white,
                      fontWeight: FontWeight.w500,
                      titleSize: 16,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  spaceHorizontal30,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomHeaderWidget(
                  "${imageList[selectedIndex].descriptions}",
                  titleColor: AppColors.instance.white,
                  fontWeight: FontWeight.w500,
                  textSize: 14,
                  maxLines: 15,
                  ellipsis: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: PhotoViewGallery.builder(
                    itemCount: imageList.length,
                    builder: (context, index) {
                      var obj = imageList[index];
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage("${obj.imagePath}"),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    pageController: _controller,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
              if (imageList.length > 1)
                DotsIndicator(
                  dotsCount: imageList.length,
                  position: selectedIndex,
                  decorator: DotsDecorator(
                    size: const Size(5.0, 5.0),
                    activeSize: const Size(5.0, 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    activeColor: AppColors.instance.appColor,
                    color: AppColors.instance.lightGray.withOpacity(0.3),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              spaceVertical20,
            ],
          ),
        );
      },
    );
  }
}
