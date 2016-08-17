//
//  AppDelegate.swift
//  NetworkInformation
//
//  Created by Paul on 7/20/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit

// Reachability Specific Constants
let kINTERNET = "ReachableInternet"
let kHOST = "ReachableHost"
let HOST = "www.apple.com"
var kHOSTSTATUS = "www.apple.com not reachable"
//let ADDRESS:sockaddr_in = sockaddr(sa_len: UInt8(sizeof(sockaddr)), sa_family: sa_family_t(AF_INET), sa_data: "s_addr: 165807745")
//let ADDRESS:sockaddr = sockaddr(sa_len: UInt8(sizeof(sockaddr)), sa_family: sa_family_t(AF_INET), sa_data: inet_addr("129.6.226.9")) //14 x Int8: (Int8, Int8,...) //

// Reachability Constants and Variables
let kREACHABLEWITHWIFI = "ReachableWithWiFi"
let kNOTREACHABLE = "NotReachable"
let kREACHABLEWITHWWAN = "ReachableWithWWAN"

var reachability: Reachability?
var reachabilityStatus: String = kREACHABLEWITHWIFI
var reachabilityHostStatus: String = kHOST

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // For reachability
    var internetReach: Reachability?
    var hostReach: Reachability?
    var ipReach: Reachability?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // For reachability
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)), name: kReachabilityChangedNotification, object: nil)
        
        
        internetReach = Reachability.reachabilityForInternetConnection()
        internetReach?.startNotifier()
        if internetReach != nil {
            self.statusChangedWithReachability(internetReach!)
        }
        
        // For host reachability
        hostReach = Reachability(hostName: HOST)
        hostReach?.startNotifier()
        if hostReach != nil {
            print("hostReach: \(hostReach)")
            self.statusChangedWithReachability(hostReach!)
        }
        
        
        
        // For IP Address Availability
//        ipReach = Reachability(address: <#T##UnsafePointer<sockaddr>#>)
        
        return true
    }
    
    func reachabilityChanged(notification: NSNotification) {
        print("Reachability Status Changed...")
        
        reachability = notification.object as? Reachability
        self.statusChangedWithReachability(reachability!)
    }
    
    func statusChangedWithReachability(currentReachabilityStatus: Reachability) {
        var networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        var statusString: String = ""
        
        statusString = "StatusValue: \(networkStatus.rawValue)"
        print(statusString)
        
        if (currentReachabilityStatus == self.hostReach) {
            switch networkStatus.rawValue {
            case NotReachable.rawValue:
                print("\(HOST) Not Reachable")
                reachabilityHostStatus = kNOTREACHABLE
                break
            case ReachableViaWiFi.rawValue:
                print("\(HOST) Reachable Via WiFi")
//                reachabilityStatus = kREACHABLEWITHWIFI
                reachabilityHostStatus = kHOST
                break
            case ReachableViaWWAN.rawValue:
                print("\(HOST) Reachable Via WWAN")
//                reachabilityStatus = kREACHABLEWITHWWAN
                reachabilityHostStatus = kHOST
                break
            default:
                print("Error with networkStatus")
            }
        } else if (currentReachabilityStatus == self.internetReach) {
            
            switch networkStatus.rawValue {
            case NotReachable.rawValue:
                print("Network Not Reachable")
                reachabilityStatus = kNOTREACHABLE
                break
            case ReachableViaWiFi.rawValue:
                print("Reachable Via WiFi")
                reachabilityStatus = kREACHABLEWITHWIFI
                break
            case ReachableViaWWAN.rawValue:
                print("Reachable Via WWAN")
                reachabilityStatus = kREACHABLEWITHWWAN
                break
            default:
                print("Error with networkStatus")
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
    }

    func statusChangedWithReachabilityHost(currentReachabilityHostStatus: Reachability) {
        var networkHostStatus: NetworkStatus = currentReachabilityHostStatus.currentReachabilityStatus()
        var statusString: String = ""
        
        statusString = "StatusHostValue: \(networkHostStatus.rawValue)"
        print(statusString)
        
        switch networkHostStatus.rawValue {
        case NotReachable.rawValue:
            print("Network Not Reachable")
            reachabilityStatus = kNOTREACHABLE
            break
        case ReachableViaWiFi.rawValue:
            print("Reachable Via WiFi")
            reachabilityStatus = kREACHABLEWITHWIFI
            break
        case ReachableViaWWAN.rawValue:
            print("Reachable Via WWAN")
            reachabilityStatus = kREACHABLEWITHWWAN
            break
        default:
            print("Error with networkStatus")
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)
    }


}

