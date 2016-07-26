//
//  Protocols.swift
//  NetworkInformation
//
//  Borrowed from: stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9
//      FOR USE WITH <AppManager.swift> and <Reachability.swift>
//
//  Created by Paul on 7/26/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import Foundation
@objc protocol AppManagerDelegate:NSObjectProtocol {
    func reachabilityStatusChangeHandler(reachability:Reachability)
}
