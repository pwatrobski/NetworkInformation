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
    // Additional Network Info
    var networkCarrier:CTCarrier
    /*
    var networkCellData:CTCellularData
    var networkSubscriber:CTSubscriber
    var networkSubscriberInfo:CTSubscriberInfo
     */
    var networkInfo:CTTelephonyNetworkInfo
    var hasInternet:Bool
    var hasConnection:Bool
    var hasWiFi:Bool
    var hasMobile:Bool
    var carrierProxy:Bool
    
    // MARK: Initialization
    init?(networkCarrier: CTCarrier/*, networkCellData: CTCellularData, networkSubscriber: CTSubscriber, networkSubscriberInfo: CTSubscriberInfo*/, networkInfo: CTTelephonyNetworkInfo, hasInternet: Bool/*String*/, hasConnection: Bool, hasWiFi: Bool, hasMobile: Bool, carrierProxy: Bool) {
        // Initialize stored properties.

        // Initialize Additional Network Info
        self.networkCarrier = networkCarrier
/*        self.networkCellData = networkCellData
        self.networkSubscriber = networkSubscriber
        self.networkSubscriberInfo = networkSubscriberInfo
 */
        self.networkInfo = networkInfo
        self.hasInternet = hasInternet
        self.hasConnection = hasConnection
        self.hasMobile = hasMobile
        self.hasWiFi = hasWiFi
        self.carrierProxy = carrierProxy

        
        // Initialization should fail if there is no network name.
        if (networkCarrier.carrierName == "") {
            return nil
        }
    }
    
    func pukeInfo() -> String {
        var info:String = "CTCarrier: \(networkCarrier.carrierName!)\n"
        info += "\tMobile Country Code: \(networkCarrier.mobileCountryCode!)\n"
        info += "\tMobile Network Code: \(networkCarrier.mobileNetworkCode!)\n"
        info += "\tISO Country Code: \(networkCarrier.isoCountryCode!)\n"
        info += "\tAllows VOIP? \(networkCarrier.allowsVOIP)\n\n"
        
        info += "Mobile: \(hasMobile)\n"
        info += "Wifi: \(hasWiFi)\n"
        info += "Internet: \(hasInternet)\n"
//        info += networkCarrier + "\n"
//        info += networkCellData + "\n"
//        info += networkSubscriber + "\n"
//        info += networkSubscriberInfo + "\n"
//        info += networkInfo + "\n"
        info += "Connected: \(hasConnection)\n"
        info += "Proxy: \(carrierProxy)"
        return info //"\(networkCarrier)\n\n\(info)"
//        return "\(info)\n\(networkCarrier)\n\(networkCellData)\n\(networkSubscriber)\n\(networkSubscriberInfo)\n\(networkInfo)"
    }
}
