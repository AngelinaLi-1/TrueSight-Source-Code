import 'package:realorfake/ui/home/widgets/home_mob_screen.dart';
import 'package:realorfake/ui/home/widgets/home_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mob: const HomeMobScreen(),
      tab: const HomeTabScreen(),
      web: Container(),
    );
  }
}
