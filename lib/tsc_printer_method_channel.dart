import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:tsc_printer/constant/function_consts.dart';
import 'package:tsc_printer/data/setup_model.dart';
import 'tsc_printer_platform_interface.dart';

/// An implementation of [TscPrinterPlatform] that uses method channels.
class MethodChannelTscPrinter extends TscPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tsc_printer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(FunctionConsts.getPlatformVersion);
    return version;
  }

  @override
  Future<bool> setup(Setup setup) async {
    final result = await methodChannel.invokeMethod<bool>(
        FunctionConsts.setup, setup.toJson());
    return result ?? false;
  }

  @override
  Future<bool> connect() async {
    final result = await methodChannel.invokeMethod<bool>(FunctionConsts.connect);
    return result ?? false;
  }

  @override
  Future<bool> disconnect() async {
    final result = await methodChannel.invokeMethod<bool>(FunctionConsts.disconnect);
    return result ?? false;
  }

  @override
  Future<bool> isConnected() async {
    final result = await methodChannel.invokeMethod<bool>(FunctionConsts.isConnected);
    return result ?? false;
  }

  @override
  Future<bool> printData(Uint8List data) async {
    final result = await methodChannel.invokeMethod<bool>(FunctionConsts.print, {'data': data});
    return result ?? false;
  }
}
