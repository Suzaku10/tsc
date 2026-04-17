package szk.kawanlama.tsc_printer.print;

import android.graphics.Bitmap;

public interface IPrinter {
    void print(Bitmap img);

    Bitmap generateImage(byte[] d);

    boolean isConnected();

    boolean disconnect();

    boolean connect();
}
