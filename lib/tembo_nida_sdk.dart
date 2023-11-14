library tembo_nida_sdk;

import 'package:tembo_ui/source.dart';
import 'package:tembo_ui/tembo_ui.dart';

import 'src/views/prep_page.dart';

// NavigatorState get rootNavigator => navigatorManager.value;
NavigatorState get rootNavigator => rootNavKey.currentState!;

void startVerificationProcess(
  BuildContext context, {
  /// Color scheme to be used for all components used in the SDK.
  /// Sets the language to be used.
  ///
  /// Only Swahili(sw) and English(en) are currently supported
  TemboLocale locale = TemboLocale.en,

  /// If themeMode is null, PlatformBrightness will be checked by using MediaQuery.platformBrightnessOf(context)
  TemboThemeMode? themeMode = TemboThemeMode.light,
}) async {
  initializeUISDK(context, locale: locale, themeMode: themeMode);

  void onAgreed() => rootNavigator.to2(const PrepPage());

  await pushApp(context, "toc", TOCPage(onAgreed));
}
