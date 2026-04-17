import 'package:flutter_test/flutter_test.dart';
import 'package:tsc_printer/tsc_printer.dart';
import 'package:tsc_printer/tsc_printer_platform_interface.dart';
import 'package:tsc_printer/tsc_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTscPrinterPlatform
    with MockPlatformInterfaceMixin
    implements TscPrinterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TscPrinterPlatform initialPlatform = TscPrinterPlatform.instance;

  test('$MethodChannelTscPrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTscPrinter>());
  });

  test('getPlatformVersion', () async {
    TscPrinter tscPrinterPlugin = TscPrinter();
    MockTscPrinterPlatform fakePlatform = MockTscPrinterPlatform();
    TscPrinterPlatform.instance = fakePlatform;

    expect(await tscPrinterPlugin.getPlatformVersion(), '42');
  });
}
