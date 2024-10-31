import 'package:realorfake/ui/introduction/intro_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class IntroBloc extends Cubit<IntroState> {
  BuildContext context;
  IntroBloc(this.context) : super(IntroLoadingState());

  void clickOnLetsStart() async {
    await AppPreferences.put(AppStrings.instance.isIntroFirst, false);
    navigateTo();
  }

  void navigateTo() {
    context.pushNamedAndRemoveUntil(AppRoutes.instance.dashboard,
        predicate: (route) => false);
  }
}
