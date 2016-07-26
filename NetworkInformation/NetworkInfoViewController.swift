//
//  NetworkInfoViewController.swift
//  NetworkInformation
//
//  Created by Paul on 7/21/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit
import CoreTelephony

class NetworkInfoViewController: UIViewController, AppManagerDelegate {

    // MARK: Properties
    @IBOutlet weak var netInfoTextView: UITextView!
    
    var networks = [NetInfo]()
    var manager:AppManager = AppManager.sharedInstance
    var reachability:Reachability?
    
    // Network Information Variables
    var networkCarrier:CTCarrier = CTCarrier()
    var networkCellData:CTCellularData = CTCellularData()
    var networkSubscriber:CTSubscriber = CTSubscriber()
    var networkSubscriberInfo:CTSubscriberInfo = CTSubscriberInfo()
    var networkInfo:CTTelephonyNetworkInfo = CTTelephonyNetworkInfo()
    var hasInternet:Bool = false//String = ""
    var hasConnection:Bool = Reachability.isConnectedToNetwork()
    var carrierProxy:Bool = false

    var netInfo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // Taken from 4) of stackoverflow.com/questions/30743408/check-for-internet-connection-in-swift-2-ios-9
    func reachabilityStatusChangeHandler(reachability: Reachability) {
        if reachability.isReachable() {
            print("isReachable")
        } else {
            print("notReachable")
        }
    }
        
    func loadNetInfo() {
        // Retrieve Network Information
        networkInfo = CTTelephonyNetworkInfo()
        networkCarrier = networkInfo.subscriberCellularProvider!
        carrierProxy = networkCarrier.isProxy()
//        networkCarrier = CTCarrier()
        networkCellData = CTCellularData()
        let cellData = networkCellData.description
        networkSubscriber = CTSubscriber()
        networkSubscriberInfo = CTSubscriberInfo()
        
        print("Proxy = \(carrierProxy)")
        print("Cell Data = \(cellData)")
        
//        netInfo += networkCarrier.carrierName!
        // Checking for Internet
//        let hasInternet = reachability?.currentReachabilityStatus
        //hasInternet = (reachability?.currentReachabilityString)!
        hasConnection = Reachability.isConnectedToNetwork()
        
        

//        var hasInternet = false
        if (AppManager.sharedInstance.isReachability) {
            hasInternet = true //Reachability.currentReachabilityStatus() //(self.Reachability) //ConnectedToNetwork()
        } else {
            hasInternet = false
        }

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
        
        let defaultNetInfo = NetInfo(name: "Test", networkCarrier: networkCarrier, networkCellData: networkCellData, networkSubscriber: networkSubscriber, networkSubscriberInfo: networkSubscriberInfo, networkInfo: networkInfo, hasInternet: hasInternet, hasConnection: hasConnection, carrierProxy: carrierProxy)!
        
        //let defaultNetInfo = NetInfo(name: "Default Network Info", networkCarrier: CTCarrier(), networkCellData: CTCellularData(), networkSubscriber: CTSubscriber(), networkSubscriberInfo: CTSubscriberInfo(), networkInfo: CTTelephonyNetworkInfo(), hasInternet: "false", hasConnection: false, carrierProxy: false)
        //let defaultNetInfo = NetInfo(name: "Here's something!\nCarrier Name: \(networkCarrier.carrierName)\n\(networkCarrier)\n\n\(networkCellData)\n\n\(networkSubscriber)\n\n\(networkSubscriberInfo)\n\n\(networkInfo)\n\n\(networkInfo.currentRadioAccessTechnology)\n\nHas Internet: \(hasInternet)\n\nConnected to Network: \(hasConnection)")!//\n\nConnection via \(connectionType)")!
//        print(defaultNetInfo.name)
        networks += [defaultNetInfo]
    }
    
    // MARK: Actions
    @IBAction func refreshNetInfo(sender: UIButton) {
        print("Network count: \(networks.count)")
        if networks.count == 0 || networks[0].name.isEmpty {
            loadNetInfo()
            netInfoTextView.text = "No Network Information Available."//networks[0].name
            print(networks[0].name)
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
