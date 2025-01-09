//
//  LNPluginManager.swift
//  Runner
//
//  Created by Magic Number lengian on 2024/11/15.
//

import app_selector
import FlutterMacOS
import Foundation

/**
    用于Dart主动调起Mac OS方法
 */
class MNPluginManager: NSObject, AppSelectorDelegate {
    private static let sharedInstance = MNPluginManager()

    override private init() {
        super.init()
    }

    static func shared() -> MNPluginManager {
        return MNPluginManager.sharedInstance
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
        case "setRootPageType":
            if let arguments: [Int] = call.arguments as? [Int] {
                let type: Int = arguments[0]
                MNDartManager.shared().pageType = LNDartPageType(rawValue: type)!
            }
            print(call)
        case "selectFilePath":
            selectAppFile(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func selectAppFile(result: @escaping FlutterResult) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = ["app"]
        openPanel.begin { response in
            if response == .OK {
                if let url = openPanel.url {
                    result(url.path)
                } else {
                    result(nil)
                }
            } else {
                result(nil)
            }
        }
    }
        

}
