import 'package:tembo_ui/source.dart';

class SuccessPage extends TemboPage {
  const SuccessPage({super.key});

  @override
  String get name => "success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: ""),
      body: Container(
        constraints: kMaxConstraints,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemboText("You have successfully verified your NIN Number"),
          ],
        ),
      ),
      bottomNavigationBar: const TemboBottomButton(callback: popBackToPrevApp),
    );
  }
}
