import 'package:realorfake/data/responses/quiz_model.dart';
import 'package:realorfake/ui/result_summary/result_summary_state.dart';
import 'package:realorfake/ui/view_image/model/image_model.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ResultSummaryBloc extends Cubit<ResultSummaryState> {
  BuildContext context;
  QuizModel obj;
  String name = "";
  String image = "";
  ResultSummaryBloc(this.context, this.obj)
      : super(ResultSummaryStartedState()) {
    loadData();
  }

  void loadData() async {
    name = await AppPreferences.get(AppStrings.instance.userName, "Anonymous");
    image = await AppPreferences.get(
        AppStrings.instance.userImage, AppImages.instance.avatar);
    emit(ResultSummaryLoadedState(obj));
  }

  int getCorrectAnswerCount() {
    int successCount = 0;
    for (Question element in obj.questions ?? []) {
      if (element.isCorrect == "true") {
        successCount++;
      }
    }
    return successCount;
  }

  void viewImage(String? image) {
    List<ImageModel> mList = [];
    mList.add(ImageModel(imagePath: image, imageTitle: "", descriptions: ""));
    context.pushNamed(AppRoutes.instance.viewImage, arguments: mList);
  }

  Color markRightWrongColor(
      String? option, String? correctOption, String? selectedOption) {
    Color textColor;
    if (selectedOption == option && selectedOption == correctOption) {
      textColor = AppColors.instance.green;
    } else if (selectedOption == option && selectedOption != correctOption) {
      textColor = AppColors.instance.red;
    } else {
      textColor = AppColors.instance.transparent;
    }
    return textColor;
  }
}
