//
//  ProcessesList.swift
//  ProcessesXPCService
//
//  Created by Victor Sukochev on 11.02.2021.
//

import Foundation

@objc(ProcessesList) final class ProcessesList: NSObject, NSSecureCoding {
    var items: [ProcessInfo]
    
    init(_ items: [ProcessInfo]) {
        self.items = items
    }
    
    // MARK: - NSSecureCoding
    
    static var supportsSecureCoding = true
    
    init?(coder aDecoder: NSCoder) {
        guard let items = aDecoder.decodeObject(of: [
            NSString.self,
            NSArray.self,
            ProcessInfo.self
        ], forKey: "process_list_items") as? [ProcessInfo] else { return nil }

        self.items = items
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.items, forKey: "process_list_items")
    }
}

