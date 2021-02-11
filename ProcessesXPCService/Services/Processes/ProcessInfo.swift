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
    var user: String
    
    init(title: String, pid: String, user: String) {
        self.title = title
        self.pid = pid
        self.user = user
        
        super.init()
    }
    
    // MARK: - NSSecureCoding
    static var supportsSecureCoding = true
    
    init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(of: [
            NSString.self,
            ProcessInfo.self
        ], forKey: "process_info_title") as? String else { return nil }
        
        guard let pid = aDecoder.decodeObject(of: [
            NSString.self,
            ProcessInfo.self
        ], forKey: "process_info_pid") as? String else { return nil }
        
        guard let user = aDecoder.decodeObject(of: [
            NSString.self,
            ProcessInfo.self
        ], forKey: "process_info_user") as? String else { return nil }
        
        self.title = title
        self.pid = pid
        self.user = user
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "process_info_title")
        aCoder.encode(self.pid, forKey: "process_info_pid")
        aCoder.encode(self.user, forKey: "process_info_user")
    }
}
