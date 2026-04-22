import 'package:tsc_printer/constant/enum_consts.dart';
import 'package:tsc_printer/data/paper_setup.dart';

class Setup {
  final ConnectionType type;
  // data can be IP, Usb port, bluetooth name
  final String data;
  final PaperSetup? paperSetup;

  Setup({
    required this.type,
    required this.data,
    this.paperSetup,
  });

  factory Setup.fromJson(Map<String, dynamic> json) {
    return Setup(
      type: ConnectionType.values.byName(json['type'] as String),
      data: json['data'] as String,
      paperSetup: json['paperSetup'] != null
          ? PaperSetup.fromJson(
              Map<String, dynamic>.from(json['paperSetup'] as Map))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {'type': type.name, 'data': data};
    if (paperSetup != null) {
      map['paperSetup'] = paperSetup!.toJson();
    }
    return map;
  }
}
