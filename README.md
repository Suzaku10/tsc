# tsc_printer

A Flutter plugin for TSC Label Printers. This plugin allows you to connect to TSC printers via USB, WiFi, or Bluetooth (WiFi/BT in progress) and print labels using the TSC SDK.

## Features

- **Multiple Connection Types**: Support for USB, WiFi, and Bluetooth.
- **USB Plug & Play**: Automatic detection of TSC devices with vendor ID `4611`.
- **Image Printing**: Print labels from `Uint8List` data (converted to Bitmaps natively).
- **Connection Status**: Check if the printer is currently connected.
- **Easy Integration**: Simple API for setup, connection, and printing.

## Installation

Add `tsc_printer` to your `pubspec.yaml`:

```yaml
dependencies:
  tsc_printer:
    path: ../tsc_printer # Or use git/pub version once available
```

## Platform Setup

### Android

1.  **USB Permissions**: The plugin handles USB permission requests automatically when calling `setup` with `ConnectionType.usb`.
2.  **Min SDK**: Ensure your `minSdkVersion` is at least **21** (required for USB Host API).

## Usage

### 1. Initialize and Setup

Choose the connection type and provide necessary data (IP address for WiFi, or empty for USB if auto-detecting).

```dart
final _tscPrinter = TscPrinter();

// For USB Connection
await _tscPrinter.setup(Setup(type: ConnectionType.usb, data: ''));

// For WiFi Connection
await _tscPrinter.setup(Setup(type: ConnectionType.wifi, data: '192.168.1.100'));
```

### 2. Connect to Printer

```dart
bool connected = await _tscPrinter.connect();
if (connected) {
  print("Printer connected!");
}
```

### 3. Print Data

The plugin accepts `Uint8List` (e.g., from a rendered widget or an image file).

```dart
Uint8List imageBytes = ...; // Your image data
bool success = await _tscPrinter.printData(imageBytes);
```

### 4. Disconnect

```dart
await _tscPrinter.disconnect();
```

## API Reference

| Method | Description |
| --- | --- |
| `setup(Setup setup)` | Configures the printer connection type and data. |
| `connect()` | Opens the communication port to the printer. |
| `disconnect()` | Closes the communication port. |
| `isConnected()` | Returns whether the printer is currently connected. |
| `printData(Uint8List data)` | Sends image data to the printer for label production. |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

