import 'package:tembo_nida_sdk/src/logic/models/profile.dart';
import 'package:tembo_ui/source.dart';

class SuccessPage extends TemboPage {
  final UserInfo profile;
  const SuccessPage(this.profile, {super.key});

  @override
  String get name => "success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: ""),
      body: Container(
        constraints: kMaxConstraints,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemboText(
              "${profile.name}, We have successfully verified your NIN Number",
            ),
          ],
        ),
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: () => popBackToPrevApp(profile),
        text: "Okay",
      ),
    );
  }
}
