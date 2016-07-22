//
//  NetworkInformationTests.swift
//  NetworkInformationTests
//
//  Created by Paul on 7/20/16.
//  Copyright © 2016 NIST. All rights reserved.
//

import UIKit
import XCTest
@testable import NetworkInformation

class NetworkInformationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: NetworkInformation Tests
    // Tests to confirm that the NetInfo initializer returns when no name is provided.
    func testNetInfoInitialization() {
        // Success test.
        let potentialNetInfo = NetInfo(name: "Test Network Info")
        XCTAssertNotNil(potentialNetInfo)
        
        // Failure case.
        let noName = NetInfo(name: "")
        XCTAssertNil(noName, "Empty name is invalid")
    }
}
