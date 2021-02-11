//
//  ProcessInfo.swift
//  ProcessesXPCService
//
//  Created by Victor Sukochev on 11.02.2021.
//

import Foundation

@objc(ProcessInfo) final class ProcessInfo: NSObject, NSSecureCoding {
    var title: String
    var pid: String
    
    init(title: String, pid: String) {
        self.title = title
        self.pid = pid
        
        super.init()
    }
    
    // MARK: - NSSecureCoding
    static var supportsSecureCoding = true
    
    init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "process_info_title") as? String else {
            fatalError("Could not deserialise title.")
        }
        
        guard let pid = aDecoder.decodeObject(forKey: "process_info_pid") as? String else {
            fatalError("Could not deserialise pid.")
        }
        
        self.title = title
        self.pid = pid
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "process_info_title")
        aCoder.encode(self.pid, forKey: "process_info_pid")
    }
}
