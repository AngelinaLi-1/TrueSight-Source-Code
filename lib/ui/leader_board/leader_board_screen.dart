import 'package:realorfake/ui/leader_board/leader_board_bloc.dart';
import 'package:realorfake/ui/leader_board/widgets/leader_board_mob_screen.dart';
import 'package:realorfake/ui/leader_board/widgets/leader_board_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaderBoardBloc>(
      create: (context) => LeaderBoardBloc(context),
      child: Responsive(
        mob: const LeaderBoardMobScreen(),
        tab: const LeaderBoardTabScreen(),
        web: Container(),
      ),
    );
  }
}
