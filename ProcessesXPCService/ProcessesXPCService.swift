//
//  ProcessesXPCService.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 09.02.2021.
//

import Foundation

class ProcessesXPCService: NSObject, ProcessesXPCServiceProtocol {
    func start(onUpdate: @escaping ((ProcessesList) -> Void)) {
        let processesSevice = ProcessesService.shared
        
        processesSevice.onUpdate = { items in
            onUpdate(ProcessesList(items))
        }
        
        processesSevice.start()
    }
    
    func setFilterEnabled(_ isEnabled: Bool) {
        
    }
}
