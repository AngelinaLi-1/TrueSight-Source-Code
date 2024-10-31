import 'package:realorfake/ui/history/history_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class HistoryBloc extends Cubit<HistoryState> {
  BuildContext context;
  HistoryBloc(this.context) : super(HistoryStartedState());
}
