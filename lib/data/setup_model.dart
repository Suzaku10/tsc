import 'package:tsc_printer/constant/enum_consts.dart';

class Setup {
  final ConnectionType type;
  // data can be IP, Usb port, bluetooth name
  final String data;

  Setup({required this.type, required this.data});

  Setup.fromJson(Map<String, dynamic> json)
      : type = ConnectionType.values.byName(json['type'] as String),
        data = json['data'] as String;

  Map<String, dynamic> toJson() => {'type': type.name ,'data': data};
}