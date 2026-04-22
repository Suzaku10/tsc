package szk.kawanlama.tsc_printer.print;

import android.graphics.Bitmap;

public interface IPrinter {
    void print(Bitmap img);
    
    void setPaperSetup(szk.kawanlama.tsc_printer.model.PaperSetup paperSetup);

    Bitmap generateImage(byte[] d);

    boolean isConnected();

    boolean disconnect();

    boolean connect();
}
