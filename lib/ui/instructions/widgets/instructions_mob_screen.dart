import 'package:realorfake/ui/instructions/instructions_bloc.dart';
import 'package:realorfake/ui/instructions/instructions_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class InstructionsMobScreen extends StatefulWidget {
  const InstructionsMobScreen({super.key});

  @override
  State<InstructionsMobScreen> createState() => _InstructionsMobScreenState();
}

class _InstructionsMobScreenState extends State<InstructionsMobScreen> {
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
        background: Colors.transparent,
        backgroundAppbar: Colors.transparent,
        backgroundStatusBar: Colors.transparent,
        body: BlocBuilder<InstructionsBloc, InstructionsState>(
          builder: (context, state) {
            if (state is InstructionsLoadingState) {
              return const CustomLoadingWidget();
            }
            if (state is InstructionsErrorState) {
              return ErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<InstructionsBloc>().loadData();
                },
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spaceVertical10,
                  CustomImageLoadWidget(
                    imageUrl: AppImages.instance.appIcon,
                    height: 150,
                  ),
                  spaceVertical10,
                  CustomHeaderWidget(
                    AppStrings.instance.appName,
                    titleColor: AppColors.instance.white,
                    fontWeight: FontWeight.w700,
                    textSize: 18,
                  ),
                  spaceVertical5,
                  CustomSubHeaderWidget(
                    "In this 'Detect Fakes' experiment by Walnut Bond Education, you will encounter a series of images that could either be genuine photographs or AI-generated. The objective of this experiment is to evaluate how effectively individuals can tell apart real images from those created by AI. Carefully analyze each image and decide whether you think it’s real or AI-generated, along with how confident you feel about your decision. If you believe an image is AI-generated, you’ll have the chance to explain your reasoning.",
                    textColor: AppColors.instance.white,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.justify,
                    titleSize: 16,
                  ),
                  spaceVertical10,
                  CustomHeaderWidget(
                    "Informed Consent",
                    titleColor: AppColors.instance.white,
                    fontWeight: FontWeight.w700,
                    textSize: 18,
                  ),
                  spaceVertical5,
                  CustomSubHeaderWidget(
                    "This experiment is brought to you by Walnut Bond Education. All data collected during this activity is anonymous and used solely for research purposes. Your participation is entirely voluntary, and there are no risks involved. This activity is designed for educational purposes, and all responses will be kept confidential. If you have any questions or concerns, please feel free to reach out to us at email@email.com",
                    textColor: AppColors.instance.white,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.justify,
                    titleSize: 16,
                  ),
                  spaceVertical10,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
