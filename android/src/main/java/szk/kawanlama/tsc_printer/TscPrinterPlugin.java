package szk.kawanlama.tsc_printer;

import android.content.Context;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.graphics.Bitmap;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import szk.kawanlama.tsc_printer.consts.PluginFunction;
import szk.kawanlama.tsc_printer.model.Setup;
import szk.kawanlama.tsc_printer.print.IPrinter;
import szk.kawanlama.tsc_printer.print.impl.USBPrinter;
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
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tsc_printer");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case PluginFunction.SETUP:
        Map<String, Object> args = call.arguments();
        if (args == null) {
          result.error("404", String.format("error %s", "error"), "");
          return;
        }
        final Setup setup = Setup.fromJson(args);
        switch (setup.type) {
          case usb:
            UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
            HashMap<String, UsbDevice> deviceList = usbManager.getDeviceList();
            UsbDevice usbDevice = null;
            
            // Common TSC vendor ID is 4611 (0x1203 in Hex)
            int TSC_VENDOR_ID = 4611;
            
            // Getting the USB device that matches the TSC vendor ID to determine the manufacturer
            for (UsbDevice device : deviceList.values()) {
                if (device.getVendorId() == TSC_VENDOR_ID) {
                    usbDevice = device;
                    break;
                }
            }

            if (usbDevice == null) {
              result.error("USB_ERROR", "No USB devices found.", "");
              return;
            }

            printer = new USBPrinter(usbManager, usbDevice);
            break;
          case wifi:
            printer = new WiFiPrinter(setup.data);
            break;
          case bluetooth:
            // TODO: Ensure to implement your BluetoothPrinter logic here
            printer = new WiFiPrinter(setup.data);
            break;
        }
        result.success(true);
        break;
      case PluginFunction.CONNECT:
        boolean isConnected = printer.connect();
        result.success(isConnected);
        break;
      case PluginFunction.DISCONNECT:
        boolean isDisconnect = printer.disconnect();
        result.success(isDisconnect);
        break;
      case PluginFunction.IS_CONNECTED:
        result.success(printer.isConnected());
        break;
      case PluginFunction.PRINT:
        Bitmap img = printer.generateImage(call.argument("data"));
        printer.print(img);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    context = null;
  }
}
