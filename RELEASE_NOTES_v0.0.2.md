# Release Notes - v0.0.2

**Date:** April 22, 2026

This release introduces paper configuration settings and improves USB device selection logic for setups with multiple identical printers.

## New Features

### 📐 Paper Configuration
- **Added `PaperSetup`**: You can now define label dimensions (width and height) in the setup data.
- **Dynamic Configuration**: The printer will automatically apply the specified paper size before printing.

### 🔌 Connectivity Improvements
- **Port Mapping for USB**: Supports identifying specific USB printers when multiple devices with the same Vendor ID/Product ID are connected.
- **Refined Device Discovery**: Improved logic for filtering and selecting the correct USB port based on the provided setup data.

## Bug Fixes & Enhancements
- Improved error handling for connection failures.
- Updated method channel logic to propagate paper setup parameters to the native Android implementation.

## How to use Paper Setup
```dart
await _tscPrinter.setup(Setup(
  type: ConnectionType.usb,
  data: '1', // USB Port
  paperSetup: PaperSetup(width: 50, height: 30), // Label dimensions in mm
));
```

## Getting Started
Refer to the [README.md](README.md) for updated API details.
