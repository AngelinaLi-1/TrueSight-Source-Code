import 'package:realorfake/ui/view_image/model/image_model.dart';
import 'package:realorfake/ui/view_image/view_image_bloc.dart';
import 'package:realorfake/ui/view_image/widgets/view_image_mob_screen.dart';
import 'package:realorfake/ui/view_image/widgets/view_image_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ViewImageScreen extends StatelessWidget {
  const ViewImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var obj = ModalRoute.of(context)?.settings.arguments as List<ImageModel>;
    return BlocProvider<ViewImageBloc>(
      create: (context) => ViewImageBloc(context, obj),
      child: Responsive(
          mob: const ViewImageMobScreen(),
          tab: const ViewImageTabScreen(),
          web: Container()),
    );
  }
}
