import 'package:realorfake/ui/widgets/widgets.dart';

class HistoryMobScreen extends StatefulWidget {
  const HistoryMobScreen({super.key});

  @override
  State<HistoryMobScreen> createState() => _HistoryMobScreenState();
}

class _HistoryMobScreenState extends State<HistoryMobScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.instance.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScaffold(
        isShowAppBar: false,
        sidePadding: 0,
        background: Colors.transparent,
        backgroundAppbar: Colors.transparent,
        backgroundStatusBar: Colors.transparent,
        body: Center(
          child: CustomHeaderWidget(
            "Coming Soon!",
            textSize: 34,
            mainAxisAlignment: MainAxisAlignment.center,
            titleColor: AppColors.instance.white,
          ),
        ),
      ),
    );
  }
}
