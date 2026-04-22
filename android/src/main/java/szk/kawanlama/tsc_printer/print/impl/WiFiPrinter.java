package szk.kawanlama.tsc_printer.print.impl;

import android.graphics.Bitmap;

import com.example.tscdll.TscWifiActivity;

import szk.kawanlama.tsc_printer.print.IPrinter;

public class WiFiPrinter implements IPrinter {
    final String ip;
    private TscWifiActivity sdk = new TscWifiActivity();

    public WiFiPrinter(String ip) {
        this.ip = ip;
    }

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
    public boolean connect() {
        String res = sdk.openport(ip, 9100);
        return  res == "1";
    }

    @Override
    public boolean disconnect() {
        String res = sdk.closeport();
        return res == "1";
    }

    @Override
    public boolean isConnected() {
        return sdk.CheckIsOnline();
    }
}
