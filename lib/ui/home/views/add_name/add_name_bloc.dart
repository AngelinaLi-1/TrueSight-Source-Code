import 'package:fluttertoast/fluttertoast.dart';
import 'package:realorfake/data/responses/avatar_model.dart';
import 'package:realorfake/ui/home/views/add_name/add_name_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class AddNameBloc extends Cubit<AddNameState> {
  BuildContext context;
  final nameCtr = TextEditingController();
  String image = "";
  late AvatarModel avatarModel;
  final Map<String, dynamic> map;
  int selectedIndex = 0;

  AddNameBloc(this.context, this.map) : super(AddNameStartedState()) {
    loadData();
  }

  @override
  Future<void> close() {
    nameCtr.dispose();
    return super.close();
  }

  void loadData() {
    nameCtr.text = map['name'] ?? "";
    image = map['image'] ?? "";
    selectedIndex = map['selectedIndex'] as int;
    getAvatars(true);
  }

  void getAvatars(bool initialLoad) async {
    try {
      Map<String, dynamic> parameters = {};
      emit(AddNameLoadingState());
      var response =
          await ApiServices.instance.getAvatars(parameter: parameters);
      if (response.isSuccess) {
        avatarModel = response.data!;
        if (initialLoad) {
          if (selectedIndex == 1) {
            avatarModel.male = image;
          }
          if (selectedIndex == 2) {
            avatarModel.female = image;
          }
        }
        emit(AddNameLoadedState());
      } else {
        emit(AddNameErrorState(response.message));
      }
    } on CustomApiException catch (e) {
      emit(AddNameErrorState(e.message));
    } catch (e) {
      safePrint(e);
      emit(AddNameErrorState(e.toString()));
    }
  }

  void submitData() {
    String name = nameCtr.text.trim().toString();
    if (name.isEmpty) {
      return showToast("Please enter full name", gravity: ToastGravity.TOP);
    }
    if (selectedIndex == 0) {
      return showToast("Please select avatar", gravity: ToastGravity.TOP);
    }
    var values = {
      "name": name,
      "selectedIndex": selectedIndex,
      "image":
          selectedIndex == 1 ? avatarModel.male ?? "" : avatarModel.female ?? ""
    };
    context.pop(values: values);
  }

  void selectAvatar(int index) {
    emit(AddNameRefreshState());
    selectedIndex = index;
    emit(AddNameLoadedState());
  }
}
