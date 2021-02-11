//
//  ViewController.swift
//  Configurator
//
//  Created by Victor Sukochev on 10.02.2021.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private weak var checkboxBtn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkboxBtn.state = RemoteConnectionService.shared.isFilterEnabled ? .on : .off
    }
    
    @IBAction func onCheckboxValueChanged(_ btn: NSButton) {
        // TODO: proper view/model/DI services separation (e.g. ProcessesManager target)
        
        RemoteConnectionService.shared.setFilterEnabled(btn.state == .on)
    }
}

