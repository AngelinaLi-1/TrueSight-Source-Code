import 'package:realorfake/ui/instructions/instructions_bloc.dart';
import 'package:realorfake/ui/instructions/widgets/instructions_mob_screen.dart';
import 'package:realorfake/ui/instructions/widgets/instructions_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InstructionsBloc>(
      create: (context) => InstructionsBloc(context),
      child: Responsive(
        mob: const InstructionsMobScreen(),
        tab: const InstructionsTabScreen(),
        web: Container(),
      ),
    );
  }
}
