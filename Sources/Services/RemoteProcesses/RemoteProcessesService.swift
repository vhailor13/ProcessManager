//
//  RemoteProcessesService.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 06.02.2021.
//

import AppKit

class RemoteProcessesService: RemoteProcessesServiceProtocol {
    static let shared = RemoteProcessesService()
    
    var processes: [ProcessInfo] = []
    var onUpdate: (([ProcessInfo]) -> Void)?
    
    private var connection: NSXPCConnection?
    private var remoteService: ProcessesXPCServiceProtocol?
    
    private init() {}
    
    func start() {
        self.startConnection()
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
        
        self.remoteService?.start(onUpdate: { [unowned self] remoteProcesses in
            let items = remoteProcesses.items
            
            self.processes = items
            self.onUpdate?(items)
        })
    }
}
