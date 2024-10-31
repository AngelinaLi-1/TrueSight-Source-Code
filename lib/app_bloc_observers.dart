import 'package:realorfake/ui/widgets/widgets.dart';

class AppBlocObservers extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    safePrint('${bloc.runtimeType} Created!');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    safePrint('${bloc.runtimeType} - Changed To - $change');
  }
}
