import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tembo_ui/source.dart';

class QRCodeScannerPage extends TemboConsumerPage {
  const QRCodeScannerPage({super.key});

  @override
  ConsumerState<TemboConsumerPage> createState() => _QRCodeScannerPageState();

  @override
  String get name => "scanner";
}

class _QRCodeScannerPageState extends ConsumerState<QRCodeScannerPage> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: "Scanner"),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            controller.stop();
            pop(context, barcodes.first);
          }
        },
      ),
    );
  }
}
