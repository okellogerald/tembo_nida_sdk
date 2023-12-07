import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tembo_nida_sdk/src/views/questions_page.dart';
import 'package:tembo_nida_sdk/tembo_nida_sdk.dart';

import 'qr_code_scanner.dart';

class NIDANumberPage extends TemboStatefulPage {
  const NIDANumberPage({super.key});

  @override
  String get name => "nin";

  @override
  State<NIDANumberPage> createState() => _NIDANumberPageState();
}

class _NIDANumberPageStateView extends StatelessWidget {
  final _NIDANumberPageState state;
  const _NIDANumberPageStateView(this.state);

  @override
  Widget build(BuildContext context) {
    print(state.controller.text);
    return Scaffold(
      appBar: TemboAppBar(label: "Namba ya NIDA"),
      body: FocusWrapper(
        child: ListView(
          padding: kPagePadding,
          children: [
            // const TemboText("Tunahitaji namba yako ya NIDA ili kuendelea."),
            // vSpace(),
            TemboLabelledFormField(
              label: "Ingiza Namba ya NIDA",
              labelStyle: context.textTheme.bodyMedium.bold.withPrimaryColor,
              controller: state.controller,
              formatters: [
                OnlyIntegerFormatter(),
              ],
              textInputType: TextInputType.number,
              decoration: TemboTextFieldDecoration(
                valueStyle: context.textTheme.headlineSmall.bold,
                suffixIcon: IconButton(
                  onPressed: state.scanNidaNumber,
                  icon: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.black45,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: TemboBottomButton(
        callback: state.next,
        text: context.l.next,
      ),
    );
  }
}

class _NIDANumberPageState extends State<NIDANumberPage> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void scanNidaNumber() async {
    final code = await rootNavKey.push3<Barcode?>(const QRCodeScannerPage());
    if (code == null) return;
    if (code.type == BarcodeType.text) {
      controller.text = code.displayValue ?? "";
    }
  }

  bool validate() {
    final text = controller.compactText;
    if (text?.length != 20) {
      showErrorSnackbar("Weka namba sahihi ya NIDA");
      return false;
    }

    return true;
  }

  void next() {
    final valid = validate();
    if (!valid) return;

    rootNavigator.to3(QuestionsPage(controller.compactText!));
  }

  @override
  Widget build(BuildContext context) => _NIDANumberPageStateView(this);
}
