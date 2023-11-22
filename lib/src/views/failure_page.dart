import 'package:tembo_ui/source.dart';

class FailurePage extends TemboPage {
  const FailurePage({super.key});

  @override
  String get name => "failure";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: ""),
      body: Container(
        constraints: kMaxConstraints,
        padding: kPagePadding,
        child: Column(
          children: [
            Image.asset("packages/tembo_nida_sdk/assets/ver_failed.png",
                height: 150),
            vSpace(),
            TemboText.center(
              "Tumeshindwa kuthibitisha utambulisho wako. Kuna maswali hujayajibu kwa usahihi. Tafadhari jaribu tena baadae.",
              style: context.textTheme.bodyLarge,
            ),
            vSpace(),
            TemboTextButton(
              onPressed: () {
                rootNavKey.currentState!
                    .popUntil((route) => route.settings.name == "nin");
              },
              style: TemboButtonStyle.outline(
                foregroundColor: context.colorScheme.primary,
                textStyle: context.textTheme.bodyMedium.bold,
                borderRadius: kBorderRadius3,
              ),
              child: const TemboText("Jaribu Tena"),
            ),
            vSpace(),
            TemboTextButton(
              onPressed: () => popBackToPrevApp(true),
              style: TemboButtonStyle.outline(
                foregroundColor: context.colorScheme.primary,
                textStyle: context.textTheme.bodyMedium.bold,
                borderRadius: kBorderRadius3,
              ),
              child: const TemboText(
                "Assume Authenticated successfully",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
