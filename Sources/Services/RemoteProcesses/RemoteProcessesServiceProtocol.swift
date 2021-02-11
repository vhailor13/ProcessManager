//
//  RemoteProcessesServiceProtocol.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 06.02.2021.
//

import Foundation

protocol RemoteProcessesServiceProtocol {
    var processes: [ProcessInfo] { get }
    
    func start()
    
    // Simple async API, we can use some sort of subscription observers here
     var onUpdate: (([ProcessInfo]) -> Void)? { get set }
}
