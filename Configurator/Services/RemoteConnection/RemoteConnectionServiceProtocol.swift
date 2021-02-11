//
//  RemoteConnectionServiceProtocol.swift
//  Configurator
//
//  Created by Victor Sukochev on 10.02.2021.
//

import Foundation

protocol RemoteConnectionServiceProtocol {
    var isFilterEnabled: Bool { get }
    
    func setFilterEnabled(_ isEnabled: Bool)
}
