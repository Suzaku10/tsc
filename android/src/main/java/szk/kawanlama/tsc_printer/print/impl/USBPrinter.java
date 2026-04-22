package szk.kawanlama.tsc_printer.print.impl;

import android.graphics.Bitmap;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;

import com.example.tscdll.TSCUSBActivity;

import szk.kawanlama.tsc_printer.print.IPrinter;

public class USBPrinter implements IPrinter {
    final UsbManager manager;
    final UsbDevice device;
    public USBPrinter(UsbManager manager, UsbDevice device) {
        this.manager = manager;
        this.device = device;
    }
    final TSCUSBActivity sdk = new TSCUSBActivity();
    private szk.kawanlama.tsc_printer.model.PaperSetup paperSetup;

    @Override
    public void setPaperSetup(szk.kawanlama.tsc_printer.model.PaperSetup paperSetup) {
        if (paperSetup != null) {
            this.paperSetup = paperSetup;
        }
    }

    @Override
    public void print(Bitmap img) {
        if (paperSetup != null) {
            sdk.setup(paperSetup.width, paperSetup.height, paperSetup.speed, paperSetup.density, paperSetup.sensor, paperSetup.sensorDistance, paperSetup.sensorOffset);
        }
        
        sdk.clearbuffer();
        sdk.sendbitmap(0,0, img);
        sdk.printlabel(1,1);
    }

    @Override
    public Bitmap generateImage(byte[] d) {
        android.graphics.Bitmap bitmap = android.graphics.BitmapFactory.decodeByteArray(d, 0, d.length);
        return bitmap;
    }

    @Override
    public boolean isConnected() {
        String result = sdk.printerstatus();
        return result != "-1";
    }

    @Override
    public boolean disconnect() {
        String result = sdk.closeport();
        return result == "1";
    }

    @Override
    public boolean connect() {
        String result = sdk.openport(manager, device);
        return result != "-1";
    }
}
