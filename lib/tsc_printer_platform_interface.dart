import 'dart:typed_data';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:tsc_printer/data/setup_model.dart';
import 'tsc_printer_method_channel.dart';

abstract class TscPrinterPlatform extends PlatformInterface {
  /// Constructs a TscPrinterPlatform.
  TscPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TscPrinterPlatform _instance = MethodChannelTscPrinter();

  /// The default instance of [TscPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTscPrinter].
  static TscPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TscPrinterPlatform] when
  /// they register themselves.
  static set instance(TscPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> setup(Setup setup) {
    throw UnimplementedError('setup() has not been implemented.');
  }

  Future<bool> connect() {
    throw UnimplementedError('connect() has not been implemented.');
  }

  Future<bool> disconnect() {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future<bool> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  Future<bool> printData(Uint8List data) {
    throw UnimplementedError('printData() has not been implemented.');
  }
}
