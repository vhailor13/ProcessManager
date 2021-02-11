//
//  ProcessOptionsCell.swift
//  ProcessesManager
//
//  Created by Victor Sukochev on 11.02.2021.
//

import AppKit

class ProcessOptionsCell: NSTableCellView {
    var onKill: (() -> Void)?
    
    @IBAction private func onKillPressed(_: NSButton) {
        onKill?()
    }
}
