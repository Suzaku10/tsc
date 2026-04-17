import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tsc_printer_platform_interface.dart';

/// An implementation of [TscPrinterPlatform] that uses method channels.
class MethodChannelTscPrinter extends TscPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tsc_printer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
