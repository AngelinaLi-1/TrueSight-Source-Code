import 'package:realorfake/data/responses/quiz_model.dart';
import 'package:realorfake/ui/result_summary/result_summary_bloc.dart';
import 'package:realorfake/ui/result_summary/widgets/result_summary_mob_screen.dart';
import 'package:realorfake/ui/result_summary/widgets/result_summary_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ResultSummaryScreen extends StatelessWidget {
  const ResultSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var obj = ModalRoute.of(context)?.settings.arguments as QuizModel;
    return BlocProvider<ResultSummaryBloc>(
      create: (context) => ResultSummaryBloc(context, obj),
      child: Responsive(
        mob: const ResultSummaryMobScreen(),
        tab: const ResultSummaryTabScreen(),
        web: Container(),
      ),
    );
  }
}
