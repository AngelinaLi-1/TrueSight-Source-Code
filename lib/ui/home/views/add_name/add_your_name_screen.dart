import 'package:dotted_border/dotted_border.dart';
import 'package:realorfake/ui/home/views/add_name/add_name_bloc.dart';
import 'package:realorfake/ui/home/views/add_name/add_name_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class AddYourNameScreen extends StatefulWidget {
  const AddYourNameScreen({super.key});

  @override
  State<AddYourNameScreen> createState() => _AddYourNameScreenState();
}

class _AddYourNameScreenState extends State<AddYourNameScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNameBloc, AddNameState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: AppColors.instance.white,
                ),
                child: Column(
                  children: [
                    spaceVertical10,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Column(
                            children: [
                              CustomHeaderWidget(
                                "Your Name",
                                fontWeight: FontWeight.w600,
                                textSize: 20,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Image.asset(
                              AppImages.instance.cancelCircle,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.instance.dividerColor,
                    ),
                    spaceVertical10,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextInputWidget(
                          controller: context.read<AddNameBloc>().nameCtr,
                          hintText: "Full Name",
                          isAcceptName: true,
                          maxLength: 50,
                        ),
                        spaceVertical20,
                        BlocBuilder<AddNameBloc, AddNameState>(
                          builder: (context, state) {
                            if (state is AddNameLoadingState ||
                                state is AddNameStartedState) {
                              return SizedBox(
                                height: 100,
                                width: 100,
                                child: CustomLoadingWidget(
                                  color: AppColors.instance.appColorBottom,
                                ),
                              );
                            }
                            if (state is AddNameLoadedState) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: CustomImageLoadWidget(
                                      imageUrl: AppImages.instance.refresh,
                                      height: 30,
                                      width: 30,
                                      onClick: () {
                                        context
                                            .read<AddNameBloc>()
                                            .getAvatars(false);
                                      },
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          DottedBorder(
                                            borderType: BorderType.Circle,
                                            child: CustomImageLoadWidget(
                                              imageUrl:
                                                  "${context.read<AddNameBloc>().avatarModel.male}",
                                              height: 100,
                                              width: 100,
                                              borderRadius: 100,
                                              onClick: () {
                                                context
                                                    .read<AddNameBloc>()
                                                    .selectAvatar(1);
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: context
                                                    .read<AddNameBloc>()
                                                    .selectedIndex ==
                                                1,
                                            child: Icon(
                                              Icons.check_circle,
                                              color: AppColors.instance.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceHorizontal10,
                                      Stack(
                                        children: [
                                          DottedBorder(
                                            borderType: BorderType.Circle,
                                            child: CustomImageLoadWidget(
                                              imageUrl:
                                                  "${context.read<AddNameBloc>().avatarModel.female}",
                                              height: 100,
                                              width: 100,
                                              borderRadius: 100,
                                              onClick: () {
                                                context
                                                    .read<AddNameBloc>()
                                                    .selectAvatar(2);
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: context
                                                    .read<AddNameBloc>()
                                                    .selectedIndex ==
                                                2,
                                            child: Icon(
                                              Icons.check_circle,
                                              color: AppColors.instance.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                        spaceVertical30,
                        CustomButtonWidget(
                          title: "Submit",
                          onPressed: () {
                            context.read<AddNameBloc>().submitData();
                          },
                        ),
                        spaceVerticalBottomForButton,
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
