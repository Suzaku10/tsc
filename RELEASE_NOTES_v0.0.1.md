# Release Notes - v0.0.1

**Date:** April 20, 2026

We are excited to announce the initial release of the `tsc_printer` Flutter plugin! This version provides the foundation for connecting to and printing with TSC Label Printers on the Android platform.

## Key Features

### 🔌 Connectivity
- **USB Support**: Direct connection to TSC printers via USB.
  - Automatic device discovery for TSC Vendor ID (`4611`).
  - Integrated USB permission handling.
- **WiFi Support**: Connect via IP address and port.
- **Bluetooth (Experimental)**: Initial support for Bluetooth connectivity.

### 🖨️ Printing
- **Image Printing**: Ability to send `Uint8List` image data to be printed as labels.
- **Native Integration**: Seamlessly bridges Flutter to the official TSC Android SDK.

### 🛠️ Core API
- **Easy Setup**: Simple `setup` method to define connection parameters.
- **State Management**: Methods to `connect`, `disconnect`, and check `isConnected` status.

## Supported Platforms

- **Android**: Full support for TSC SDK integration.
- **Windows**: Initial structure added (functionality in future releases).

## Getting Started

To get started, please refer to the [README.md](README.md) for installation and usage instructions.

---
*For feedback or issues, please contact the development team.*
