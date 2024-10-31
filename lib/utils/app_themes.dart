import 'package:realorfake/ui/widgets/widgets.dart';

class AppThemes {
  static final AppThemes instance = AppThemes._internal();

  factory AppThemes() {
    return instance;
  }
  AppThemes._internal();

  ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: AppColors.instance.black,
      primaryColorLight: AppColors.instance.lightGray,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.instance.appColor,
          secondary: AppColors.instance.red,
          surface: AppColors.instance.background,
          error: AppColors.instance.red,
          brightness: Brightness.light),
      dialogBackgroundColor: AppColors.instance.background,
      dividerColor: Colors.transparent,
      appBarTheme: theme.appBarTheme.copyWith(
        color: AppColors.instance.white,
        iconTheme: IconThemeData(color: AppColors.instance.black),
        toolbarTextStyle: Theme.of(context).textTheme.headlineMedium,
        titleTextStyle: Theme.of(context).textTheme.headlineLarge,
      ),
      textTheme: theme.textTheme
          .copyWith(
            labelLarge: theme.textTheme.labelLarge?.copyWith(
              fontSize: 16,
              color: AppColors.instance.textColor,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w700,
            ),
            labelMedium: theme.textTheme.labelMedium?.copyWith(
              fontSize: 14,
              color: AppColors.instance.textColor,
              fontWeight: FontWeight.w400,
              fontFamily: 'WorkSans',
            ),
            labelSmall: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.instance.textColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'WorkSans',
            ),
            titleLarge: theme.textTheme.titleLarge?.copyWith(
              fontSize: 24,
              color: AppColors.instance.textColor,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
            ),
            titleMedium: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              color: AppColors.instance.textColor,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
            ),
            titleSmall: theme.textTheme.titleSmall?.copyWith(
              fontSize: 16,
              color: AppColors.instance.textColor,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              color: AppColors.instance.textColor,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w700,
            ),
            bodyMedium: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.instance.textColor,
              fontSize: 16,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
            ),
            bodySmall: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.instance.textColor,
              fontSize: 14,
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w500,
            ),
          )
          .apply(fontFamily: 'WorkSans'),
      buttonTheme: theme.buttonTheme.copyWith(
          minWidth: 50,
          buttonColor: AppColors.instance.appColor,
          textTheme: ButtonTextTheme.primary),
    );
  }
}
