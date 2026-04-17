
import 'tsc_printer_platform_interface.dart';

class TscPrinter {
  Future<String?> getPlatformVersion() {
    return TscPrinterPlatform.instance.getPlatformVersion();
  }
}
