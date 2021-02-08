//
//  CommandServiceProtocol.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 07.02.2021.
//

import AppKit

protocol CommandServiceProtocol {
    func execute(_ command: String, onComplete: ((String) -> Void)?)
}
