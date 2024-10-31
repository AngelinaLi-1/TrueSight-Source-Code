import 'package:realorfake/ui/view_image/model/image_model.dart';
import 'package:realorfake/ui/view_image/view_image_state.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ViewImageBloc extends Cubit<ViewImageState> {
  BuildContext context;
  final List<ImageModel> mList;
  ViewImageBloc(this.context, this.mList) : super(ViewImageStartedState());
}
