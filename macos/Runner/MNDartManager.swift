//
//  LNDartManager.swift
//  Runner
//
//  Created by Magic Number lengian on 2024/11/15.
//


import Foundation
import FlutterMacOS

enum LNDartPageType : Int{
    case scan
    case detail
}

/**
    用于Mac OS主动调起调起Dart方法
 */
class MNDartManager : NSObject {
    // 静态属性用于存储单例的唯一实例
    private static let sharedInstance = MNDartManager()

    // 私有构造函数，防止外部创建实例
    private override init() {
        super.init()
    }

    // 类方法，返回单例的唯一实例
    static func shared() -> MNDartManager {
        return MNDartManager.sharedInstance
    }
    
    /** 方法通道
        flutterMethodChannel?.invokeMethod("isSelectingAppPath", arguments: nil, result: { result in
            print(result)
        })
     */
    var flutterMethodChannel : FlutterMethodChannel?;
    
    var pageType: LNDartPageType = LNDartPageType.scan

}

