//
//  CommandService.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 07.02.2021.
//

import Foundation

class CommandService: CommandServiceProtocol {
    static let shared = CommandService()
    
    private init() {}
    
    func execute(_ command: String, onComplete: ((String) -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.executeSync(command)
            onComplete?(result)
        }
    }
    
    // MARK: -
    
    private func executeSync(_ command: String) -> String {
        let pipe = Pipe()
        
        // Using bash proccess
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", command]
        task.standardOutput = pipe
        
        // Launch & output
        let file = pipe.fileHandleForReading
        task.launch()
        
        guard  let result = String(data: file.readDataToEndOfFile(), encoding: .utf8)  else {
            // TODO: Add some error handling logic
            
            return ""
        }
        
        return result
    }
}
