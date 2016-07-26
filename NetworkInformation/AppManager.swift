//
//  AppManager.swift
//  NetworkInformation
//
//  Taken from: stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9
//  need to add functionality/use different reachabilty class:
//      https://github.com/ashleymills/Reachability.swift
//  Created by Paul on 7/25/16.
//  Copyright © 2016 NIST. All rights reserved.
//

//import Foundation
import UIKit

class AppManager: NSObject {
    var delegate:AppManagerDelegate? = nil
    private var _useClosures:Bool = false
    private var reachability: Reachability?
    private var _isReachability:Bool = false
    private var _reachabilityNetworkType :String?
    
    var isReachability:Bool {
        get {return _isReachability}
    }
    
    var reachabilityNetworkType:String {
        get {return _reachabilityNetworkType!}
    }
    
    // Create a shared instance of AppManager
    final class var sharedInstance : AppManager {
        struct Static {
            static var instance : AppManager?
        }
        if !(Static.instance != nil) {
            Static.instance = AppManager()
        }
        return Static.instance!
    }
    
    // Reachability Methods
    func initReachabilityMonitor() {
        print("initialize reachability...")
        do {
            let reachability = try Reachability.reachabilityForInternetConnection()
            self.reachability = reachability
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
            print("Unable to create\nReachability with address:\n\(address)")
        } catch {}
        
        if (_useClosures) {
            reachability?.whenReachable = {
                reachability in self.notifyReachability(reachability)
            }
            reachability?.whenUnreachable = {
                reachability in self.notifyReachability(reachability)
            }
        } else {
            self.notifyReachability(reachability!)
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("unable to start notifier")
            return
        }
    }
    
    private func notifyReachability(reachability:Reachability) {
        if reachability.isReachable() {
            self._isReachability = true
            
            // Determine Network Type
            if reachability.isReachableViaWiFi() {
                self._reachabilityNetworkType = CONNECTION_NETWORK_TYPE.WIFI_NETWORK.rawValue
            } else {
                self._reachabilityNetworkType = CONNECTION_NETWORK_TYPE.WWAN_NETWORK.rawValue
            }
        } else {
            self._isReachability = false
            self._reachabilityNetworkType = CONNECTION_NETWORK_TYPE.OTHER.rawValue
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppManager.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        dispatch_async(dispatch_get_main_queue()) {
            self.delegate?.reachabilityStatusChangeHandler(reachability)
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        if (!_useClosures) {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        }
    }
}