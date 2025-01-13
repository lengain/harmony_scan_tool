//
//  MNFlutterMainViewController.swift
//  Runner
//
//  Created by 童玉龙 on 2025/1/9.
//

import Foundation
import FlutterMacOS
class MNFlutterMainViewController : FlutterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        run(conmands: ["which", "java"])
        run(conmands: ["java","--version"])
        run(conmands: ["/Users/tongyulong/.sdkman/candidates/java/current/bin/java", "--version"])
        runAppleScript(source: "java --version")
//        runXpc()
    
    }
    
    func run(conmands:[String]) {
        let result = MNCommand.runCommand(arguments: conmands)
        print(result.stdout)
        print(result.stderr)
    }
    func runAppleScript(source:String) {
        let result = MNCommand.runCommandWithAppleScript(command: source)
        print(result.stdout)
        print(result.stderr)
    }
    
//    func runXpc() {
//        var connectionToService = NSXPCConnection(serviceName: "com.lengain.MNCommandXPC")
//        connectionToService.remoteObjectInterface = NSXPCInterface(with: MNCommandXPCProtocol.self)
//        connectionToService.resume()
//
////    Once you have a connection to the service, you can use it like this:
//
//        if let proxy = connectionToService.remoteObjectProxy as? MNCommandXPCProtocol {
//            proxy.performCalculation(firstNumber: 23, secondNumber: 19) { result in
//                NSLog("Result of calculation is: \(result)")
//            }
//        }
//    }
}
