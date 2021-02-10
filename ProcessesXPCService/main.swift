//
//  main.swift
//  ProcessesXPCService
//
//  Created by Victor Sukochev on 09.02.2021.
//

import Foundation

let listener = NSXPCListener.service()
let listenerDelegate = ListenerDelegate()

listener.delegate = listenerDelegate

listener.resume()
