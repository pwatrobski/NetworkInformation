//
//  NetworkInfoViewController.swift
//  NetworkInformation
//
//  Created by Paul on 7/21/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit
import CoreTelephony

class NetworkInfoViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var netInfoTextView: UITextView!
    
    var networks = [NetInfo]()
    
    var netInfo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func loadNetInfo() {
        // Retrieve Network Information
        let networkCarrier = CTCarrier()
        let networkCellData = CTCellularData()
        let networkSubscriber = CTSubscriber()
        let networkSubscriberInfo = CTSubscriberInfo()
        let networkInfo = CTTelephonyNetworkInfo()
        
        let defaultNetInfo = NetInfo(name: "Here's something!\n\(networkCarrier)\n\n\(networkCellData)\n\n\(networkSubscriber)\n\n\(networkSubscriberInfo)\n\n\(networkInfo)\n\n\(networkInfo.currentRadioAccessTechnology)")!
        print(defaultNetInfo.name)
        networks += [defaultNetInfo]
    }
    
    // MARK: Actions
    @IBAction func refreshNetInfo(sender: UIButton) {
        if networks.count == 0 || networks[0].name.isEmpty {
            loadNetInfo()
            netInfoTextView.text = "No Network Infromation Available."//networks[0].name
            print(networks[0].name)
        } else {
            loadNetInfo()
//            for i in 0..<networks.count {
//                netInfo += networks[i].name + "\n"
//                netInfoTextView.text = "Network info available."
                netInfoTextView.text = networks[0].name
                print("Retrieving network info.")
//            }
        }
    }

}
