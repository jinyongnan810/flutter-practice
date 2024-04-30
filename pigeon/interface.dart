import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon.dart',
  dartOptions: DartOptions(),
  swiftOut: 'ios/Runner/Pigeon.swift',
  swiftOptions: SwiftOptions(),
))
class ToNativeParams {
  String message;
  int times;
}

class ToFlutterParams {
  String message;
  double batteryLevel;
}

@HostApi()
abstract class TestNativeApi {
  @async
  ToFlutterParams sendMessage(ToNativeParams params);
}

@FlutterApi()
abstract class TestFlutterApi {
  void onGotBatteryLevel(double batteryLevel);
}
