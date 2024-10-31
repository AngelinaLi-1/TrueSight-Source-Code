import 'package:realorfake/ui/instructions/instructions_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class InstructionsBloc extends Cubit<InstructionsState> {
  BuildContext context;

  InstructionsBloc(this.context) : super(InstructionsStartedState()) {
    loadData();
  }

  void loadData() async {}
}
