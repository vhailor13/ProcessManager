//
//  ProcessesServiceProtocol.swift
//  ProcessesXPCService
//
//  Created by Victor Sukochev on 11.02.2021.
//

import Foundation

protocol ProcessesServiceProtocol {
    var onUpdate: (([ProcessInfo]) -> Void)? { get set }
    
    func start()
}
