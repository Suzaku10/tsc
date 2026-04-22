package szk.kawanlama.tsc_printer.model;

import java.util.Map;
import java.util.HashMap;

public class PaperSetup {
    public int width = 50;
    public int height = 30;
    public int speed = 4;
    public int density = 8;
    public int sensor = 0;
    public int sensorDistance = 0;
    public int sensorOffset = 0;

    public static PaperSetup fromJson(Map<String, Object> json) {
        if (json == null) return null;
        PaperSetup setup = new PaperSetup();
        
        try {
            if (json.get("width") != null) setup.width = Integer.parseInt(String.valueOf(json.get("width")));
            if (json.get("height") != null) setup.height = Integer.parseInt(String.valueOf(json.get("height")));
            if (json.get("speed") != null) setup.speed = Integer.parseInt(String.valueOf(json.get("speed")));
            if (json.get("density") != null) setup.density = Integer.parseInt(String.valueOf(json.get("density")));
            if (json.get("sensor") != null) setup.sensor = Integer.parseInt(String.valueOf(json.get("sensor")));
            if (json.get("sensorDistance") != null) setup.sensorDistance = Integer.parseInt(String.valueOf(json.get("sensorDistance")));
            if (json.get("sensorOffset") != null) setup.sensorOffset = Integer.parseInt(String.valueOf(json.get("sensorOffset")));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return setup;
    }

    public Map<String, Object> toJson() {
        Map<String, Object> json = new HashMap<>();
        json.put("width", width);
        json.put("height", height);
        json.put("speed", speed);
        json.put("density", density);
        json.put("sensor", sensor);
        json.put("sensorDistance", sensorDistance);
        json.put("sensorOffset", sensorOffset);
        return json;
    }
}
