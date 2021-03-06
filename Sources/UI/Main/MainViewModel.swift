//
//  MainViewModel.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 07.02.2021.
//

import Foundation

class MainViewModel {
    
    var onUpdate: (([ProcessInfo]) -> Void)?
    
    private var processesService: RemoteProcessesServiceProtocol
    
    init() {
        // TODO: use DI
        self.processesService = RemoteProcessesService.shared
        
        self.setupUpdates()
        self.start()
    }
    
    func kill(_ process: ProcessInfo) {
        self.processesService.kill(process)
    }
    
    // MARK: -
    
    private func start() {
        self.processesService.start()
    }
    
    private func setupUpdates() {
        self.processesService.onUpdate = { [weak self] list in
            self?.onUpdate?( list )
        }
    }
}
