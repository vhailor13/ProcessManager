//
//  ViewController.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 06.02.2021.
//

import Cocoa

class MainViewController: NSViewController {
    
    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBindings()
    }

    // MARK: -
    
    func setupBindings() {
        self.viewModel.onUpdate = { [weak self] list in
            print("\(list)")
        }
    }
}

