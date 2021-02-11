//
//  ViewController.swift
//  Configurator
//
//  Created by Victor Sukochev on 10.02.2021.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func onCheckboxValueChanged(_ btn: NSButton) {
        // TODO: proper view/model/DI services separation (e.g. ProcessesManager target)
        
        RemoteConnectionService.shared.setFilterEnabled(btn.state == .on)
    }
}

