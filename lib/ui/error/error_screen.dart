import 'package:realorfake/ui/widgets/widgets.dart';

class ErrorScreen extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  const ErrorScreen({super.key, this.message, this.onRetry});

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
              mainAxisAlignment: MainAxisAlignment.center,
              textSize: 20,
            ),
            spaceVertical20,
            CustomButtonWidget(
              title: "Retry",
              onPressed: onRetry != null ? onRetry! : () {},
            ),
          ],
        ),
      ),
    );
  }
}
