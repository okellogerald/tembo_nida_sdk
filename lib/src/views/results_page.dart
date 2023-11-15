import 'package:tembo_nida_sdk/src/logic/models/result.dart';
import 'package:tembo_ui/source.dart';

class ResultsPage extends TemboPage {
  final List<Result> results;
  const ResultsPage(this.results, {super.key});

  @override
  String get name => "results";

  int get rightResults {
    return results.where((e) => e.right).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(
        label: "Your Results",
        onBackPress: popBackToPrevApp,
      ),
      body: Padding(
        padding: kPagePadding + bottom(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemboText.bold(
              "You got $rightResults questions correct out of ${results.length}",
              style: context.textTheme.bodyMedium.withPrimaryColor,
            ),
            vSpace(),
            Expanded(
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (context, index) => vSpace(30),
                itemBuilder: (context, index) {
                  return buildResult(results[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const TemboBottomButton(
        callback: popBackToPrevApp,
        text: "Okay",
      ),
    );
  }

  Widget buildResult(Result result) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TemboFormLabel("Question (English)"),
          buildQn(result.question.inEnglish),
          vSpace(),
          const TemboFormLabel("Question (Swahili)"),
          buildQn(result.question.inSwahili),
          vSpace(),
          TemboLabelledFormField.disabled(
            label: "Answer",
            value: result.answer,
            decoration: result.right
                ? const TemboTextFieldDecoration(
                    borderColor: Colors.green,
                    borderWidth: 2,
                    suffixIcon: Icon(Icons.check, color: Colors.green),
                  )
                : TemboTextFieldDecoration(
                    borderColor: LightTemboColors.error,
                    borderWidth: 2,
                    suffixIcon: const Icon(
                      Icons.close,
                      color: LightTemboColors.error,
                    ),
                    valueStyle: context.textTheme.bodyLarge.withColor(
                      context.colorScheme.onBackground,
                    ),
                  ),
          ),
        ],
      );
    });
  }

  Widget buildQn(String data) {
    return Builder(builder: (context) {
      return TemboText(
        data,
        style: context.textTheme.bodyMedium.withFW600.withColor(
          context.colorScheme.onSurface,
        ),
      );
    });
  }
}
