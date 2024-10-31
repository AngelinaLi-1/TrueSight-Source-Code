import 'package:realorfake/ui/splash/splash_bloc.dart';
import 'package:realorfake/ui/splash/widgets/splash_mob_screen.dart';
import 'package:realorfake/ui/splash/widgets/splash_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(context),
      child: Responsive(
        mob: const SplashMobScreen(),
        tab: const SplashTabScreen(),
        web: Container(),
      ),
    );
  }
}
