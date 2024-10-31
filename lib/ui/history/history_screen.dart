import 'package:realorfake/ui/history/history_bloc.dart';
import 'package:realorfake/ui/history/widgets/history_mob_screen.dart';
import 'package:realorfake/ui/history/widgets/history_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create: (context) => HistoryBloc(context),
      child: Responsive(
        mob: const HistoryMobScreen(),
        tab: const HistoryTabScreen(),
        web: Container(),
      ),
    );
  }
}
