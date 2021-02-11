//
//  ProcessesXPCServiceProtocol.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 09.02.2021.
//

import Foundation

@objc protocol ProcessesXPCServiceProtocol {
    func start(onUpdate: @escaping ((ProcessesList) -> Void))
    func update()
    func kill(_ process: ProcessInfo)
    
    func isFilterEnabled() -> Bool
    func setFilterEnabled(_ isEnabled: Bool)
}
