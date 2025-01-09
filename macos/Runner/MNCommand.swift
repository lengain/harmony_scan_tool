//
//  LNCommand.swift
//  Runner
//
//  Created by Magic Number lengian on 2024/11/23.
//

import Foundation
class MNCommand {
    
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
