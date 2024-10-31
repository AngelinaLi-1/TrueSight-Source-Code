import 'package:realorfake/ui/widgets/widgets.dart';

class EmptyListScreen extends StatelessWidget {
  final String? message;
  const EmptyListScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomHeaderWidget(
              message,
              titleColor: AppColors.instance.white,
              textAlign: TextAlign.center,
              textSize: 24,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
