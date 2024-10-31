import 'package:realorfake/ui/introduction/intro_bloc.dart';
import 'package:realorfake/ui/introduction/widgets/intro_mob_screen.dart';
import 'package:realorfake/ui/introduction/widgets/intro_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroBloc>(
      create: (context) => IntroBloc(context),
      child: Responsive(
        mob: const IntroMobScreen(),
        tab: const IntroTabScreen(),
        web: Container(),
      ),
    );
  }
}
