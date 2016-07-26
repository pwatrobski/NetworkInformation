//
//  NetInfo.swift
//  NetworkInformation
//
//  Created by Paul on 7/21/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit
import CoreTelephony

class NetInfo {
    // MARK: Properties
    
    var name: String
    var mobile: Bool
    var wifi: Bool
    
    // Additional Network Info
    var networkCarrier:CTCarrier
    var networkCellData:CTCellularData
    var networkSubscriber:CTSubscriber
    var networkSubscriberInfo:CTSubscriberInfo
    var networkInfo:CTTelephonyNetworkInfo
    var hasInternet:Bool
    var hasConnection:Bool
    var carrierProxy:Bool
    
    // MARK: Initialization
    init?(name: String, networkCarrier: CTCarrier, networkCellData: CTCellularData, networkSubscriber: CTSubscriber, networkSubscriberInfo: CTSubscriberInfo, networkInfo: CTTelephonyNetworkInfo, hasInternet: Bool/*String*/, hasConnection: Bool, carrierProxy: Bool) {
        // Initialize stored properties.
        self.name = name
        self.mobile = false
        self.wifi = false

        // Initialize Additional Network Info
        self.networkCarrier = networkCarrier
        self.networkCellData = networkCellData
        self.networkSubscriber = networkSubscriber
        self.networkSubscriberInfo = networkSubscriberInfo
        self.networkInfo = networkInfo
        self.hasInternet = hasInternet
        self.hasConnection = hasConnection
        self.carrierProxy = carrierProxy

        
        // Initialization should fail if there is no network name.
        if name.isEmpty {
            return nil
        }
    }
    
    func pukeInfo() -> String {
        var info:String = name + "\n"
        info += "Mobile: \(mobile)\n"
        info += "Wifi: \(wifi)\n"
        info += "Internet: \(hasInternet)\n"
//        info += networkCarrier + "\n"
//        info += networkCellData + "\n"
//        info += networkSubscriber + "\n"
//        info += networkSubscriberInfo + "\n"
//        info += networkInfo + "\n"
        info += "Connected: \(hasConnection)\n"
        info += "Proxy: \(carrierProxy)"
        return "\(info)\n\(networkCarrier)\n\(networkCellData)\n\(networkSubscriber)\n\(networkSubscriberInfo)\n\(networkInfo)"
    }
}
