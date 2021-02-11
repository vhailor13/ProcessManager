//
//  ProcessesXPCService.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 09.02.2021.
//

import Foundation

class ProcessesXPCService: NSObject, ProcessesXPCServiceProtocol {
    
    func start(onUpdate: @escaping ((ProcessesList) -> Void)) {
        // TODO: use DI
        let processesSevice = ProcessesService.shared
        
        processesSevice.onUpdate = { items in
            onUpdate(ProcessesList(items))
        }
        
        processesSevice.update()
    }
    
    func update() {
        ProcessesService.shared.update()
    }
    
    func kill(_ process: ProcessInfo) {
        ProcessesService.shared.kill(process)
    }
    
    func setFilterEnabled(_ isEnabled: Bool) {
        ProcessesService.shared.isUserFilterEnabled = isEnabled
    }
    
    func isFilterEnabled() -> Bool
    {
        return ProcessesService.shared.isUserFilterEnabled
    }
}
