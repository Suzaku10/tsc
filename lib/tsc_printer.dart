import 'dart:typed_data';
import 'package:tsc_printer/data/setup_model.dart';
import 'tsc_printer_platform_interface.dart';

export 'package:tsc_printer/constant/enum_consts.dart';
export 'package:tsc_printer/data/setup_model.dart';
export 'package:tsc_printer/data/paper_setup.dart';

class TscPrinter {
  Future<String?> getPlatformVersion() {
    return TscPrinterPlatform.instance.getPlatformVersion();
  }

  Future<bool> setup(Setup setup) {
    return TscPrinterPlatform.instance.setup(setup);
  }

  Future<bool> connect() {
    return TscPrinterPlatform.instance.connect();
  }

  Future<bool> disconnect() {
    return TscPrinterPlatform.instance.disconnect();
  }

  Future<bool> isConnected() {
    return TscPrinterPlatform.instance.isConnected();
  }

  Future<bool> printData(Uint8List data) {
    return TscPrinterPlatform.instance.printData(data);
  }
}
