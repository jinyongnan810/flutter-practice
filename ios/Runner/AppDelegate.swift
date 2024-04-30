import UIKit
#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

extension FlutterError: Error {}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller = window?.rootViewController as! FlutterViewController
    let nativeApi = NativeImpl(binaryMessenger: controller.binaryMessenger)
    TestNativeApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: nativeApi)
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private class NativeImpl: TestNativeApi {
    private let flutterApi: TestFlutterApi
    private var timer: Timer?
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.flutterApi = TestFlutterApi(binaryMessenger: binaryMessenger)
    }
    
    func sendMessage(params: ToNativeParams, completion: @escaping (Result<ToFlutterParams, any Error>) -> Void) {
        print("from flutter: \(params.message) \(params.times).")
        self.timer?.invalidate()
        self.timer = nil
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            self?.checkBatteryLevel()
        }
        
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        // return battery level by returning value directly
        completion(.success(ToFlutterParams(message: "hello from native", batteryLevel: Double(device.batteryLevel))))
    }
    
    func checkBatteryLevel() {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        // return battery level by calling flutterApi
        self.flutterApi.onGotBatteryLevel(batteryLevel: Double(device.batteryLevel)) {
            _ in
        }
    }
}
