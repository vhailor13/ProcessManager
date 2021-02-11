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
        
    var isUserFilterEnabled: Bool {
        get {
            UserDefaults.standard.synchronize()
            
            return UserDefaults.standard.bool(forKey: "is_filter_enabled")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "is_filter_enabled")
            UserDefaults.standard.synchronize()
        }
    }
    
    private let commandService: CommandServiceProtocol
    private weak var timer: Timer?
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private init() {
        // TODO: Use DI
        self.commandService = CommandService.shared
    }
    
    func update() {
        let command = self.isUserFilterEnabled ? "ps -eo pid,user,comm | grep $USER" : "ps -eo pid,user,comm"
        self.commandService.execute(command) { [unowned self] result in
            let list = self.parseProcesses(result)
            
            self.onUpdate?(list)
        }
    }
    
    func kill(_ process: ProcessInfo) {
        let command = "kill -9 \(process.pid)"
        self.commandService.execute(command) { [unowned self] result in
            self.update()
        }
    }
    
    // MARK: -
    
    private func parseProcesses(_ listStr: String) -> [ProcessInfo] {
        var lines = listStr.components(separatedBy: .newlines)
        lines.removeFirst()
        
        return lines.compactMap({
            let fields = $0.components(separatedBy: .whitespaces).filter({ !$0.isEmpty })
            
            guard fields.count == 3 else { return nil }
            
            return ProcessInfo(title: fields[2], pid: fields[0], user: fields[1])
        })
    }
}
