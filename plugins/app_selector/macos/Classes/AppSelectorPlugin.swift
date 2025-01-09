import Cocoa
import FlutterMacOS

public protocol  AppSelectorDelegate {
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)
}

public class AppSelectorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "app_selector", binaryMessenger: registrar.messenger)
        let instance = AppSelectorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    var delegate:AppSelectorDelegate?
    
    public static func register(with registrar: FlutterPluginRegistrar, delegate:AppSelectorDelegate ) {
        let channel = FlutterMethodChannel(name: "app_selector", binaryMessenger: registrar.messenger)
        let instance = AppSelectorPlugin()
        instance.delegate = delegate
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    /**
     if no method  result(FlutterMethodNotImplemented)
     */
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        delegate?.handle(call, result: result)
    }


}
