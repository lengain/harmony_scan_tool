//
//  LNCommand.swift
//  Runner
//
//  Created by Magic Number lengian on 2024/11/23.
//

import Cocoa
class MNCommand {
    //do shell script "java --version" with administrator privileges
    static func runCommandWithAppleScript(command :String) -> (stdout: String, stderr: String) {
        let source = "do shell script \"\(command)\""
        print(source)
        let appleScript = NSAppleScript.init(source: source)
        var error : NSDictionary?
        let result = appleScript?.executeAndReturnError(&error)
        if error != nil {
            return ("", String(describing: error!))
        }else {
            let output : String = result?.stringValue ?? ""
            return (output, "")
        }
    }
    
    /// path:usr/bin/env
    static func runCommand(arguments: [String], launchPath: String = "/usr/bin/env") -> (stdout: String, stderr: String) {
        let task = Process()
        task.launchPath = launchPath
        
        task.arguments = arguments
        
        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        
        task.standardOutput = stdoutPipe
        task.standardError = stderrPipe
        
        let stdoutFileHandle = stdoutPipe.fileHandleForReading
        let stderrFileHandle = stderrPipe.fileHandleForReading
        
        task.launch()
        
        let stdoutData = stdoutFileHandle.readDataToEndOfFile()
        let stderrData = stderrFileHandle.readDataToEndOfFile()
        
        task.waitUntilExit()
        
        return (String(data: stdoutData, encoding: .utf8)!, String(data: stderrData, encoding: .utf8)!)
    }
    
    
}
