import 'package:realorfake/ui/widgets/widgets.dart';

class RealFakeApp extends StatefulWidget {
  const RealFakeApp({super.key});

  @override
  State<RealFakeApp> createState() => _RealFakeAppState();
}

class _RealFakeAppState extends State<RealFakeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.instance.appName,
      theme: AppThemes.instance.of(context),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.instance.registerRoutes(),
    );
  }
}
