import 'package:tembo_nida_sdk/src/views/nin_number_page.dart';
import 'package:tembo_nida_sdk/tembo_nida_sdk.dart';
import 'package:tembo_ui/source.dart';

class PrepPage extends TemboPage {
  const PrepPage({super.key});

  @override
  String get name => "prep-page";

  @override
  State<PrepPage> createState() => _PrepPageState();
}

class _PrepPageState extends State<PrepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: "Prep Page"),
      body: Padding(
        padding: kHorPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TemboText.center("We want to verify your identity with NIDA"),
            vSpace(),
            const TemboText.bold("Steps"),
            ListView.separated(
              itemCount: _steps.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const TemboDivider(),
              itemBuilder: (context, i) {
                return ListTile(
                  leading: TemboText("${i + 1}"),
                  title: TemboText(_steps[i]),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: onPressed,
        text: "I am ready. Let's go!",
      ),
    );
  }

  onPressed() {
    rootNavigator.to(const NIDANumberPage());
  }
}

const _steps = [
  "Enter the NIDA Number(NIN)",
  "Answer Questions",
  "Be Approved",
];
