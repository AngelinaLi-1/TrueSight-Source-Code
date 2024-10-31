import 'package:realorfake/ui/dashboard/dashboard_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class DashboardBloc extends Cubit<DashboardState> {
  BuildContext context;
  DashboardBloc(this.context) : super(DashboardStartedState());
}
