//
//  ListenerDelegate.swift
//  ProcessesXPCService
//
//  Created by Victor Sukochev on 09.02.2021.
//

import Foundation

class ListenerDelegate: NSObject, NSXPCListenerDelegate {
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: ProcessesXPCServiceProtocol.self)
        newConnection.exportedObject = ProcessesXPCService()
        
        newConnection.invalidationHandler = { print("Connection did invalidate") }
        newConnection.interruptionHandler = { print("Connection did interrupt") }
        
        newConnection.resume()
        
        return true;
    }
}
