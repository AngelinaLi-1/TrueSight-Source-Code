import 'package:realorfake/ui/history/history_screen.dart';
import 'package:realorfake/ui/home/home_bloc.dart';
import 'package:realorfake/ui/home/home_screen.dart';
import 'package:realorfake/ui/instructions/instructions_screen.dart';
import 'package:realorfake/ui/profile/profile_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class DashboardMobScreen extends StatefulWidget {
  const DashboardMobScreen({super.key});

  @override
  State<DashboardMobScreen> createState() => _DashboardMobScreenState();
}

class _DashboardMobScreenState extends State<DashboardMobScreen> {
  int selectedIndex = 0;
  final pages = [
    const HomeScreen(),
    const HistoryScreen(),
    const InstructionsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        color: AppColors.instance.appColorBottom,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: AppColors.instance.hintColor,
            selectedItemColor: AppColors.instance.appColor,
            selectedIconTheme:
                IconThemeData(color: AppColors.instance.appColor),
            backgroundColor: AppColors.instance.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (int index) {
              if (context.read<HomeBloc>().isQuizStarted) {
                context.showAlertDialog(
                  isShowSuccessImage: false,
                  message:
                      "Kindly complete the quiz before you can perform any further actions.",
                  okButtonText: "Okay",
                );
                return;
              }
              if (index == 1) {
                context.pushNamed(AppRoutes.instance.leaderBoard);
              } else {
                setState(() {
                  selectedIndex = index;
                });
              }
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomHome,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.lightGray,
                ),
                activeIcon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomHomeSelected,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.appColorBottom,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomHistory,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.lightGray,
                ),
                activeIcon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomHistorySelected,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.appColorBottom,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomQuestion,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.lightGray,
                ),
                activeIcon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomQuestionSelected,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.appColorBottom,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomProfile,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.lightGray,
                ),
                activeIcon: CustomImageLoadWidget(
                  imageUrl: AppImages.instance.bottomProfileSelected,
                  height: 22,
                  width: 20,
                  imageColor: AppColors.instance.appColorBottom,
                ),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
