//
//  RemoteConnectionService.swift
//  Configurator
//
//  Created by Victor Sukochev on 10.02.2021.
//

import Foundation

class RemoteConnectionService: RemoteConnectionServiceProtocol {
    static let shared = RemoteConnectionService()
    
    private var connection: NSXPCConnection?
    private var remoteService: ProcessesXPCServiceProtocol?
    
    private init() {
        self.startConnection()
    }
    
    private func startConnection() {
        self.connection = NSXPCConnection(serviceName: "com.victor.ProcessesXPCService")
        self.connection?.remoteObjectInterface = NSXPCInterface(with: ProcessesXPCServiceProtocol.self)
        
        self.connection?.invalidationHandler = { NSLog("Connection did invalidate") }
        self.connection?.interruptionHandler = { NSLog("Connection did interrupt") }
        
        
        self.connection?.resume()
        self.remoteService = self.connection?.remoteObjectProxyWithErrorHandler({ error in
            NSLog("Error: description: \(error as NSError)")
        }) as? ProcessesXPCServiceProtocol
    }
    
    func setFilterEnabled(_ isEnabled: Bool) {
        self.remoteService?.setFilterEnabled(isEnabled)
    }
}
