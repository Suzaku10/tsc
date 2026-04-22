package szk.kawanlama.tsc_printer.model;

import java.util.Map;
import java.util.HashMap;

import szk.kawanlama.tsc_printer.consts.ConnectionType;

public class Setup {
    public ConnectionType type;
    public String data;
    public PaperSetup paperSetup;

    public Setup() {}

    public Setup(ConnectionType type, String data) {
        this.type = type;
        this.data = data;
    }

    public static Setup fromJson(Map<String, Object> json) {
        Setup setup = new Setup();

        if (json.get("type") != null) {
            setup.type = ConnectionType.valueOf((String) json.get("type"));
        }

        if (json.get("data") != null) {
            setup.data = (String) json.get("data");
        }

        if (json.get("paperSetup") != null) {
            setup.paperSetup = PaperSetup.fromJson((Map<String, Object>) json.get("paperSetup"));
        }

        return setup;
    }

    public Map<String, Object> toJson() {
        Map<String, Object> json = new HashMap<>();

        json.put("type", type.name());
        json.put("data", data);

        return json;
    }
}
