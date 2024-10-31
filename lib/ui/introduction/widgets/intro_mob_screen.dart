import 'package:dots_indicator/dots_indicator.dart';
import 'package:realorfake/ui/introduction/intro_bloc.dart';
import 'package:realorfake/ui/introduction/intro_state.dart';
import 'package:realorfake/ui/introduction/widgets/item_intro_widget.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class IntroMobScreen extends StatefulWidget {
  const IntroMobScreen({super.key});

  @override
  State<IntroMobScreen> createState() => _IntroMobScreenState();
}

class _IntroMobScreenState extends State<IntroMobScreen> {
  int selectedIndex = 0;
  final _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.white,
      body: BlocBuilder<IntroBloc, IntroState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.instance.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  spaceVertical15,
                  Expanded(
                    child: SizedBox(
                      child: PageView(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {
                            selectedIndex = value;
                          });
                        },
                        children: [
                          ItemIntroWidget(
                            imagePath: AppImages.instance.intro1,
                            title: "Welcome",
                            subTitle: "We’re glad that you are here",
                            imageHeight: 350,
                            imageRightPadding: 70,
                            onClick: () {
                              context.read<IntroBloc>().clickOnLetsStart();
                            },
                          ),
                          ItemIntroWidget(
                            imagePath: AppImages.instance.intro2,
                            title: "Unmask the Fake",
                            subTitle: "Bringing Clarity to the Digital World",
                            onClick: () {
                              context.read<IntroBloc>().clickOnLetsStart();
                            },
                          ),
                          ItemIntroWidget(
                            imagePath: AppImages.instance.intro3,
                            title: "Verify with Confidence",
                            subTitle: "Protecting You from Digital Deception",
                            onClick: () {
                              context.read<IntroBloc>().clickOnLetsStart();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: 3,
                    position: selectedIndex,
                    decorator: DotsDecorator(
                      activeSize: const Size(60, 12),
                      size: const Size(35, 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      activeColor: AppColors.instance.appColor,
                      color: AppColors.instance.white,
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  spaceVerticalBottomForButton,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
