//
//  DeliverNow_v2Tests.swift
//  DeliverNow-v2Tests
//
//  Created by 滕施男 on 7/05/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import XCTest
@testable import DeliverNow_v2

class DeliverNow_v2Tests: XCTestCase {
    
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
    
    func testUIAlertViewShowsAfterViewLoads() -> Void {
        class FakeAlertView: UIAlertView {
            var showWasCalled = false
            
            private override func show() {
                showWasCalled = true
            }
        }
        
        let vc = MapViewController()
        vc.alertView = FakeAlertView()
        vc.viewDidLoad()
        XCTAssertTrue((vc.alertView as! FakeAlertView).showWasCalled, "Show was not called...")
    }
    
}
