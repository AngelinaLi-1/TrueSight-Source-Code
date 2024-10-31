import 'package:flutter/services.dart';
import 'package:realorfake/app_bloc_observers.dart';
import 'package:realorfake/ui/real_fake_app.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  AppPreferences.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = AppBlocObservers();
  runApp(const RealFakeApp());
}
