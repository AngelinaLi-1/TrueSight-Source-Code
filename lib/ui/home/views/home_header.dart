import 'package:realorfake/ui/home/home_bloc.dart';
import 'package:realorfake/ui/home/home_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HomeHeaderView extends StatelessWidget {
  final VoidCallback? onClickProfile;
  const HomeHeaderView({super.key, this.onClickProfile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageLoadWidget(
          imageUrl: AppImages.instance.splashLogo,
          height: 61,
          width: 61,
        ),
        Expanded(
          child: GestureDetector(
            onTap: onClickProfile,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomHeaderWidget(
                  "Welcome".toUpperCase(),
                  titleColor: AppColors.instance.textColor2,
                  textSize: 12,
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return CustomHeaderWidget(
                      context.read<HomeBloc>().userName,
                      titleColor: AppColors.instance.white,
                      mainAxisAlignment: MainAxisAlignment.end,
                      maxLines: 1,
                      ellipsis: TextOverflow.ellipsis,
                      textSize: 20,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        spaceHorizontal15,
        GestureDetector(
          onTap: onClickProfile,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return CustomImageLoadWidget(
                imageUrl: context.read<HomeBloc>().userImage,
                height: 56,
                width: 56,
                borderRadius: 100,
                imagePlaceHolder: AppImages.instance.avatar,
              );
            },
          ),
        ),
        spaceHorizontal15,
      ],
    );
  }
}
