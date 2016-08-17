//
//  NetworkInfoViewController.swift
//  NetworkInformation
//
//  Created by Paul on 7/21/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit
import CoreTelephony

class NetworkInfoViewController: UIViewController/*, AppManagerDelegate*/ {

    // MARK: Properties
    @IBOutlet weak var netInfoTextView: UITextView!
    
    var networks = [NetInfo]()
//    var manager:AppManager = AppManager.sharedInstance
    var reachability:Reachability?
    
    // Network Information Variables
    var networkCarrier:CTCarrier = CTCarrier()
    var networkCellData:CTCellularData = CTCellularData()
    var networkSubscriber:CTSubscriber = CTSubscriber()
    var networkSubscriberInfo:CTSubscriberInfo = CTSubscriberInfo()
    var networkInfo:CTTelephonyNetworkInfo = CTTelephonyNetworkInfo()
    var hasInternet:Bool = false//String = ""
    var carrierProxy:Bool = false
    var hasWiFi:Bool = false
    var hasMobile:Bool = false
    var hasConnection:Bool = false
    //    var hasConnection:Bool = Reachability.isConnectedToNetwork()
    
    var netInfo: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NetworkInfoViewController.loadNetInfo)/*#selector(NetworkInfoViewController.reachabilityStatusChanged)*/, name: "ReachStatusChanged", object: nil)
        
    }
    
    // Taken from 4) of stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9
    /*
    func reachabilityStatusChangeHandler(reachability: Reachability) {
        if reachability.isReachable() {
            print("isReachable")
        } else {
            print("notReachable")
        }
    }
    */
    func loadNetInfo() {
        // Retrieve Network Information
        networkInfo = CTTelephonyNetworkInfo()
        networkCarrier = networkInfo.subscriberCellularProvider!
        carrierProxy = networkCarrier.isProxy()
        
        //let thing = getSignalStrength()
        //print(thing)

        // Other Core Telephony methods that didn't prove fruitful
        /*
        networkCarrier = CTCarrier()
        networkCellData = CTCellularData() //CellularData
        networkSubscriber = CTSubscriber()
        networkSubscriberInfo = CTSubscriberInfo()
         */

        
        // Checking for Internet
//        let hasInternet = reachability?.currentReachabilityStatus
        //hasInternet = (reachability?.currentReachabilityString)!
//        hasConnection = Reachability.isConnectedToNetwork()
        
        switch (reachabilityStatus) {
        case kNOTREACHABLE:
            hasConnection = false
            hasInternet = false
            break
        case kREACHABLEWITHWIFI:
            hasConnection = true
            hasInternet = true
            hasWiFi = true
            break
        case kREACHABLEWITHWWAN:
            hasConnection = true
            hasInternet = true
            hasMobile = true
            break
        default:
            hasConnection = false
            hasInternet = false
            hasWiFi = false
            hasMobile = false
        }
        

//        var hasInternet = false
        /*
        if (AppManager.sharedInstance.isReachability) {
            hasInternet = true //Reachability.currentReachabilityStatus() //(self.Reachability) //ConnectedToNetwork()
        } else {
            hasInternet = false
        }
         */
        
        // Check if certain address is reachable
        // IP address for laptop(129.6.226.9)
        // Might be able to check for access to a particular host
        // stackoverflow.com/questions/9393645/reachabilitywithaddress-error-giving-it-an-ip-address
        
        
        // Checking for Connection Type
//        let connectionType = AppManager.sharedInstance.reachabilityNetworkType
        /*
        if (AppManager.sharedInstance.reachabilityNetworkType == "Wifi") {
            print(".Wifi")
        } else if (AppManager.sharedInstance.reachabilityNetworkType == "Cellular") {
            print(".Cellular")
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                print("Network not reachable")
            }
        }
        */
        
        //let thing = reachability.reachabilityForInternetConnection()
        
        let defaultNetInfo = NetInfo(networkCarrier: networkCarrier/*, networkCellData: networkCellData, networkSubscriber: networkSubscriber, networkSubscriberInfo: networkSubscriberInfo*/, networkInfo: networkInfo, hasInternet: hasInternet, hasConnection: hasConnection, hasWiFi: hasWiFi, hasMobile: hasMobile, carrierProxy: carrierProxy)!
        
        //let defaultNetInfo = NetInfo(name: "Default Network Info", networkCarrier: CTCarrier(), networkCellData: CTCellularData(), networkSubscriber: CTSubscriber(), networkSubscriberInfo: CTSubscriberInfo(), networkInfo: CTTelephonyNetworkInfo(), hasInternet: "false", hasConnection: false, carrierProxy: false)
        //let defaultNetInfo = NetInfo(name: "Here's something!\nCarrier Name: \(networkCarrier.carrierName)\n\(networkCarrier)\n\n\(networkCellData)\n\n\(networkSubscriber)\n\n\(networkSubscriberInfo)\n\n\(networkInfo)\n\n\(networkInfo.currentRadioAccessTechnology)\n\nHas Internet: \(hasInternet)\n\nConnected to Network: \(hasConnection)")!//\n\nConnection via \(connectionType)")!
//        print(defaultNetInfo.name)
        networks += [defaultNetInfo]
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case kNOTREACHABLE:
            print("Not Reachable")
            break
        case kREACHABLEWITHWIFI:
            print("Reachable with WiFi")
            break
        case kREACHABLEWITHWWAN:
            print("Reachable with WWAN")
            break
        default:
            print("Reachability Error")
        }
    }
    
    // MARK: Actions
    @IBAction func refreshNetInfo(sender: UIButton) {
        print("Network count: \(networks.count)")
        if networks.count == 0 {
            loadNetInfo()
            netInfoTextView.text = "No Network Information Available."//networks[0].name
        } else {
            print("Retrieving network info.")

            loadNetInfo()
            netInfoTextView.text = networks[networks.count-1].pukeInfo()
//            for i in 0..<networks.count {
//                netInfo += networks[i].name + "\n"
//                netInfoTextView.text = "Network info available."
//                netInfoTextView.text = networks[i].name
//                netInfoTextView.text = networks[0].name
//            }
        }
    }

}
