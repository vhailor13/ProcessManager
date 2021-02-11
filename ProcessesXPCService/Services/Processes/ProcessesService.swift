//
//  ProcessesService.swift
//  ProcessesXPCService
//
//  Created by Victor Sukochev on 11.02.2021.
//

import Foundation

class ProcessesService: ProcessesServiceProtocol {
    static let shared = ProcessesService()
    
    var onUpdate: (([ProcessInfo]) -> Void)?
    
    private let commandService: CommandServiceProtocol
    
    private init() {
        // TODO: Use DI
        self.commandService = CommandService.shared
    }
    
    func start() {
        self.commandService.execute("ps -eo pid,comm") { [unowned self] result in
            let list = self.parseProcesses(result)
            
            self.onUpdate?(list)
        }
    }
    
    // MARK: -
    
    private func parseProcesses(_ listStr: String) -> [ProcessInfo] {
        var lines = listStr.components(separatedBy: .newlines)
        lines.removeFirst()
        
        return lines.compactMap({
            let fields = $0.components(separatedBy: .whitespaces)
            
            guard fields.count == 2 else { return nil }
            
            return ProcessInfo(title: fields[1], pid: fields[0])
        })
    }
}
