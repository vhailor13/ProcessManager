//
//  ViewController.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 06.02.2021.
//

import Cocoa

class MainViewController: NSViewController {
    
    private let viewModel = MainViewModel()
    
    @IBOutlet private weak var tableView: NSTableView!
    
    private var items: [ProcessInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBindings()
    }

    // MARK: -
    
    func setupBindings() {
        self.viewModel.onUpdate = { [weak self] list in
            DispatchQueue.main.async {
                self?.items = list
                self?.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let item = self.items[row]
        
        if tableColumn == tableView.tableColumns[0] {
            let identifier = NSUserInterfaceItemIdentifier(rawValue: "ProcessCellTitle")
            let cell = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
            cell?.textField?.stringValue = item.title
            
            return cell
        }
        
        if tableColumn == tableView.tableColumns[1] {
            let identifier = NSUserInterfaceItemIdentifier(rawValue: "ProcessCellPid")
            let cell = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
            cell?.textField?.stringValue = item.pid
            
            return cell
        }
        
        if tableColumn == tableView.tableColumns[2] {
            let identifier = NSUserInterfaceItemIdentifier(rawValue: "ProcessCellOptions")
            let cell = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
            
            
            return cell
        }
        
        return nil
    }
}

