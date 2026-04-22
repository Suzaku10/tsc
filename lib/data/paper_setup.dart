import 'package:tsc_printer/constant/enum_consts.dart';

class PaperSetup {
  final int width;
  final int height;
  final int speed;
  final int density;
  final int sensor;
  final int sensorDistance;
  final int sensorOffset;

  PaperSetup({
    this.width = 50,
    this.height = 30,
    this.speed = 4,
    this.density = 8,
    this.sensor = 0,
    this.sensorDistance = 0,
    this.sensorOffset = 0,
  });

  factory PaperSetup.fromJson(Map<String, dynamic> json) {
    return PaperSetup(
      width: json['width'] as int? ?? 50,
      height: json['height'] as int? ?? 30,
      speed: json['speed'] as int? ?? 4,
      density: json['density'] as int? ?? 8,
      sensor: json['sensor'] as int? ?? 0,
      sensorDistance: json['sensorDistance'] as int? ?? 0,
      sensorOffset: json['sensorOffset'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'speed': speed,
      'density': density,
      'sensor': sensor,
      'sensorDistance': sensorDistance,
      'sensorOffset': sensorOffset,
    };
  }
}
