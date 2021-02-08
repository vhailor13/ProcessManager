//
//  ProcessesServiceProtocol.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 06.02.2021.
//

import Foundation

struct ProcessInfo {
    let title: String
    let pid: String
}

protocol ProcessesServiceProtocol {
    var processes: [ProcessInfo] { get }
    
    // Simple async API, we can use some sort of subscription observers here
     var onUpdate: (([ProcessInfo]) -> Void)? { get set }
    
    func sync()
}
