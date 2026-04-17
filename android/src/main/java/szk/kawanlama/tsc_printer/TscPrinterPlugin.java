package szk.kawanlama.tsc_printer;

import android.graphics.Bitmap;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import szk.kawanlama.tsc_printer.print.IPrinter;
import szk.kawanlama.tsc_printer.print.impl.WiFiPrinter;

/** TscPrinterPlugin */
public class TscPrinterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private IPrinter printer;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tsc_printer");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
    /// TODO: check sdk
    printer = new WiFiPrinter("124.252.53.1");
    switch (call.method) {
      case "connect":
        boolean isConnected = printer.connect();
        result.success(isConnected);
      case "disconnect":
        boolean isDisconnect = printer.disconnect();
        result.success(isDisconnect);
      case "isConnected":
        result.success(printer.isConnected());
      case "print":
        Bitmap img = printer.generateImage(call.argument("data"));
        printer.print(img);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
