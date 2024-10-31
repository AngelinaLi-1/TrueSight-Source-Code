import 'package:realorfake/ui/dashboard/dashboard_screen.dart';
import 'package:realorfake/ui/instructions/instructions_screen.dart';
import 'package:realorfake/ui/introduction/intro_screen.dart';
import 'package:realorfake/ui/leader_board/leader_board_screen.dart';
import 'package:realorfake/ui/result_summary/result_summary_screen.dart';
import 'package:realorfake/ui/splash/splash_screen.dart';
import 'package:realorfake/ui/view_image/view_image_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class AppRoutes {
  static final AppRoutes instance = AppRoutes._internal();

  factory AppRoutes() {
    return instance;
  }
  AppRoutes._internal();

  final splash = '/';
  final introduction = 'introduction';
  final dashboard = 'dashboard';
  final leaderBoard = 'leaderBoard';
  final viewImage = 'viewImage';
  final resultSummary = 'resultSummary';
  final instructions = 'instructions';

  Map<String, WidgetBuilder> registerRoutes() {
    return <String, WidgetBuilder>{
      splash: (context) => const SplashScreen(),
      introduction: (context) => const IntroScreen(),
      dashboard: (context) => const DashboardScreen(),
      leaderBoard: (context) => const LeaderBoardScreen(),
      viewImage: (context) => const ViewImageScreen(),
      resultSummary: (context) => const ResultSummaryScreen(),
      instructions: (context) => const InstructionsScreen(),
    };
  }
}
