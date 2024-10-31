import 'package:realorfake/ui/profile/profile_bloc.dart';
import 'package:realorfake/ui/profile/widgets/profile_mob_screen.dart';
import 'package:realorfake/ui/profile/widgets/profile_tab_screen.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(context),
      child: Responsive(
        mob: const ProfileMobScreen(),
        tab: const ProfileTabScreen(),
        web: Container(),
      ),
    );
  }
}
