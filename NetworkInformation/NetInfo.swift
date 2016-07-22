//
//  NetInfo.swift
//  NetworkInformation
//
//  Created by Paul on 7/21/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit

class NetInfo {
    // MARK: Properties
    
    var name: String
    var mobile: Bool
    var wifi: Bool
    var internet: Bool
    
    // MARK: Initialization
    init?(name: String) {
        // Initialize stored properties.
        self.name = name
        self.mobile = false
        self.wifi = false
        self.internet = false
        
        // Initialization should fail if there is no network name.
        if name.isEmpty {
            return nil
        }
    }
}
