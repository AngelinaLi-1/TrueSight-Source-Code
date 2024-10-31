import 'package:realorfake/ui/splash/splash_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class SplashBloc extends Cubit<SplashState> {
  BuildContext context;
  SplashBloc(this.context) : super(SplashStartedState()) {
    appStarted();
  }

  void appStarted() async {
    AppStrings.token =
        await AppPreferences.get(AppStrings.instance.userToken, "");
    bool isFirstTime =
        await AppPreferences.get(AppStrings.instance.isIntroFirst, true);
    Timer(const Duration(seconds: 2), () async {
      if (isFirstTime) {
        navigateToIntroScreen();
      } else {
        navigateToHome();
      }
    });
  }

  void navigateToIntroScreen() {
    context.pushNamedAndRemoveUntil(AppRoutes.instance.introduction,
        predicate: (route) => false);
  }

  void navigateToHome() {
    context.pushNamedAndRemoveUntil(AppRoutes.instance.dashboard,
        predicate: (route) => false);
  }
}
