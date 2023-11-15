import 'package:tembo_nida_sdk/src/views/nin_number_page.dart';
import 'package:tembo_nida_sdk/tembo_nida_sdk.dart';
import 'package:tembo_ui/components/container/decoration.dart';
import 'package:tembo_ui/source.dart';

class PrepPage extends TemboStatefulPage {
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
      appBar: TemboAppBar(label: "Utangulizi"),
      body: ListView(
        padding: kHorPadding,
        children: [
          Padding(
            padding: bottom(20),
            child: Image.asset("packages/tembo_nida_sdk/assets/face-id.png",
                height: 180),
          ),
          TemboText.center(
            "Ili kuendelea kutumia huduma hii unahitaji kuthibitisha utambulisho wako wa NIDA. Hii ni kwa ajili ya kuhakikisha usalama wa pesa zako.",
            style: context.textTheme.bodyLarge,
          ),
          vSpace(30),
          Padding(
            padding: left(25),
            child: TemboText.bold(
              "Hatua za Kufuata:",
              style: context.textTheme.bodyLarge.withPrimaryColor,
            ),
          ),
          ListView.separated(
            itemCount: _steps.length,
            shrinkWrap: true,
            padding: left(25),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => vSpace(0),
            itemBuilder: (context, i) {
              return ListTile(
                leading: TemboContainer(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: TemboBoxDecoration(
                    color: context.colorScheme.surfaceTint,
                    radius: kBorderRadius2,
                  ),
                  child: TemboText(
                    "${i + 1}",
                    style: context.textTheme.bodyMedium.bold.withOnPrimaryColor,
                  ),
                ),
                title: TemboText(_steps[i]),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: onPressed,
        text: "Endelea",
      ),
    );
  }

  onPressed() {
    rootNavigator.to2(const NIDANumberPage());
  }
}

const _steps = [
  "Ingiza Namba ya NIDA",
  "Jibu Maswali kutoka NIDA",
  "Pata Majibu",
];
