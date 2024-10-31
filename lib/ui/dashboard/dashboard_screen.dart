import 'package:realorfake/ui/dashboard/dashboard_bloc.dart';
import 'package:realorfake/ui/dashboard/widgets/dashboard_mob_screen.dart';
import 'package:realorfake/ui/dashboard/widgets/dashboard_tab_screen.dart';
import 'package:realorfake/ui/home/home_bloc.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(context)),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(context)),
      ],
      child: Responsive(
        mob: const DashboardMobScreen(),
        tab: const DashboardTabScreen(),
        web: Container(),
      ),
    );
  }
}
