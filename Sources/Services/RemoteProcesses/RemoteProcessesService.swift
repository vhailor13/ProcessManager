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
    private weak var timer: Timer?
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private init() {}
    
    func start() {
        self.startConnection()
        self.startUpdates()
    }
    
    func kill(_ process: ProcessInfo) {
        self.remoteService?.kill(process)
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
    
    private func startUpdates() {
        self.timer?.invalidate()
        self.timer = nil
        
        let timer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.remoteService?.update()
        }
        
        self.timer = timer
        
        RunLoop.main.add(timer, forMode: .default)
    }
}
