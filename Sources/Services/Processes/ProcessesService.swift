//
//  ProcessesService.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 06.02.2021.
//

import AppKit

class ProcessesService: ProcessesServiceProtocol {
    static let shared = ProcessesService()
    
    var processes: [ProcessInfo] = []
    var onUpdate: (([ProcessInfo]) -> Void)?
    
    private let commandService: CommandServiceProtocol
    
    private var connection: NSXPCConnection?
    private var remoteService: ProcessesXPCServiceProtocol?
    
    private init() {
        // TODO: Use DI
        
        self.commandService = CommandService.shared
        
        self.startConnection()
    }
    
    func sync() {
        self.processes.removeAll()
   
        self.commandService.execute("ps -eo pid,pcpu") { [unowned self] result in
            let list = self.parseProcesses(result)
            self.processes = list
            
            self.onUpdate?(list)
        }
        /*
        let applications = NSWorkspace.shared.runningApplications
        applications.forEach { application in
            self.processes.append(ProcessInfo(
                title: application.localizedName,
                pid: application.processIdentifier
            ))
        }
 */
    }
    
    // MARK: -
    
    private func startConnection() {
        self.connection = NSXPCConnection(serviceName: "com.victor.ProcessesXPCService")
        self.connection?.remoteObjectInterface = NSXPCInterface(with: ProcessesXPCServiceProtocol.self)
        
        self.connection?.invalidationHandler = { NSLog("Connection did invalidate") }
        self.connection?.interruptionHandler = { NSLog("Connection did interrupt") }
        
        
        self.connection?.resume()
        self.remoteService = self.connection?.remoteObjectProxyWithErrorHandler({ error in
            NSLog("Error: description: \(error as NSError)")
        }) as? ProcessesXPCServiceProtocol
        
        self.remoteService?.start()
    }
    
    private func parseProcesses(_ listStr: String) -> [ProcessInfo] {
        return listStr.components(separatedBy: .newlines).compactMap({
            let fields = $0.components(separatedBy: .punctuationCharacters)
            
            guard fields.count == 2 else { return nil }
            
            return ProcessInfo(title: fields[0], pid: fields[1])
        })
    }
}
