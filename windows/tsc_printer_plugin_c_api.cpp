#include "include/tsc_printer/tsc_printer_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "tsc_printer_plugin.h"

void TscPrinterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  tsc_printer::TscPrinterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
