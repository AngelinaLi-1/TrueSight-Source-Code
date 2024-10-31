import 'package:realorfake/ui/splash/splash_bloc.dart';
import 'package:realorfake/ui/splash/splash_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class SplashMobScreen extends StatefulWidget {
  const SplashMobScreen({super.key});

  @override
  State<SplashMobScreen> createState() => _SplashMobScreenState();
}

class _SplashMobScreenState extends State<SplashMobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.instance.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(
              width: AppSizes.instance.getScreenWidth(context),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 60, left: 50, right: 50),
                      child: CustomImageLoadWidget(
                        imageUrl: AppImages.instance.splashLogo,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: CustomImageLoadWidget(
                  //     imageUrl: AppImages.instance.splashLogo1,
                  //     width: 330,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
